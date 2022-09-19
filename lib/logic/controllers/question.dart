import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/data/repository/firestore.dart';
import 'package:quiz/data/repository/quiz_api.dart';
import 'package:quiz/logic/model/question.dart';
import 'package:quiz/logic/model/score.dart';
import 'package:quiz/presentation/screens/result/result.dart';

class QuestionController extends GetxController {
  final int _questionLimit = 10;

  final QuizAPI _quizAPI = QuizAPI();
  final FirestoreDB _firestoreDB = FirestoreDB();
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  String _category = '';
  String _difficulty = '';
  RxList<Question> questions = <Question>[].obs;
  RxInt questionNumber = 1.obs;
  Question get currentQuestion => questions[questionNumber.value - 1];
  final RxList<String> _chosenAnswers = <String>[].obs;
  RxList<String> get chosenAnswers => _chosenAnswers;
  Rx<AnswerResult> answerResult = AnswerResult.notAnsweredYet.obs;
  int _correctAnswers = 0;

  @override
  void onInit() {
    super.onInit();
    Map<String, String> args = Get.arguments;
    _category = args['category'] ?? 'Linux';
    _difficulty = args['difficulty'] ?? 'Easy';
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _getQuestions();
  }

  Future<void> _getQuestions() async {
    questions.value = await _quizAPI.getQuestions(
        category: _category, difficulty: _difficulty, limit: _questionLimit);
    for (Question i in questions) {
      if (i.multipleCorrectAnswers) {
        print(i.question);
      }
    }
  }

  void choseAnswer(String answer) {
    if (!currentQuestion.multipleCorrectAnswers) {
      _chosenAnswers.value = [];
    }
    _chosenAnswers.add(answer);
  }

  void unchooseAnswer(String answer) {
    _chosenAnswers.remove(answer);
  }

  void checkAnswers() {
    if (_chosenAnswers.isEmpty) {
      answerResult.value = AnswerResult.notChosen;
      update();
      return;
    }
    for (String answer in _chosenAnswers) {
      if (!currentQuestion.correctAnswers.contains(answer)) {
        answerResult.value = AnswerResult.incorrect;
        update();
        return;
      }
    }
    for (String answer in currentQuestion.correctAnswers) {
      if (!_chosenAnswers.contains(answer)) {
        answerResult.value = AnswerResult.partially;
        update();
        return;
      }
    }
    answerResult.value = AnswerResult.correct;
    _correctAnswers++;
    update();
  }

  void goToNextQuestion() {
    if (questionNumber < _questionLimit) {
      answerResult.value = AnswerResult.notAnsweredYet;
      chosenAnswers.value = [];
      questionNumber++;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  void finishQuiz() {
    Get.off(
      () {
        return ResultScreen(
          correctAnswers: _correctAnswers,
          questionsCount: questions.length,
        );
      },
    );
  }

  Future<bool> saveScore() async {
    String? id = await _firestoreDB.saveScore(Score(
      id: '-',
      category: _category,
      difficulty: _difficulty,
      datetime: Timestamp.now(),
      questionsCount: questions.length,
      correctAnswers: _correctAnswers,
    ));
    if (id != null) {
      return true;
    } else {
      return false;
    }
  }
}

enum AnswerResult {
  correct,
  partially,
  incorrect,
  notChosen,
  notAnsweredYet,
}
