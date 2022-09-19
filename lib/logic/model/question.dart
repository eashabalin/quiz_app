import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';

class Question {
  int id;
  String question;
  String? description;
  late List<String> answers;
  bool multipleCorrectAnswers;
  late List<String> correctAnswers;
  String? explanation;
  String? tip;
  String category;
  String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.description,
    required Map<String, String?> answersJson,
    required this.multipleCorrectAnswers,
    required Map<String, bool?> correctAnswersJson,
    required this.explanation,
    required this.tip,
    required this.category,
    required this.difficulty,
  }) {
    answers = _answers(rawAnswers: answersJson);
    correctAnswers = _correctAnswers(
        rawCorrectAnswers: correctAnswersJson, rawAnswers: answersJson);
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  List<String> _answers({required Map<String, String?> rawAnswers}) {
    List<String> answers = [];
    rawAnswers.forEach((key, value) {
      if (value != null) {
        answers.add(value);
      }
    });
    return answers;
  }

  List<String> _correctAnswers(
      {required Map<String, bool?> rawCorrectAnswers,
      required Map<String, String?> rawAnswers}) {
    List<String> correctAnswers = [];
    rawAnswers.forEach((key, value) {
      if (rawCorrectAnswers['${key}_correct'] == true && value != null) {
        correctAnswers.add(value);
      }
    });
    return correctAnswers;
  }
}
