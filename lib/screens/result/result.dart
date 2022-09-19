import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/logic/controllers/question.dart';
import 'package:quiz/screens/home/home.dart';
import 'package:quiz/utils/colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.questionsCount,
  });

  final int correctAnswers;
  final int questionsCount;

  @override
  Widget build(BuildContext context) {
    final QuestionController c = Get.find();

    Future<void> showDialogAfterSaving(String title, String text) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.darkBlue),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.darkBlue),
        backgroundColor: AppColors.white,
        title: Text(
          'Result',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$correctAnswers/$questionsCount',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              const Text(
                'answered correctly',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              MaterialButton(
                textColor: AppColors.white,
                color: AppColors.darkBlue,
                child: const Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Get.offAll(() {
                    return const HomeScreen();
                  });
                },
              ),
              MaterialButton(
                textColor: AppColors.white,
                color: AppColors.darkBlue,
                child: const Text(
                  'Save score',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  bool isSaved = await c.saveScore();
                  String title = '';
                  String message = '';
                  if (isSaved) {
                    title = 'Success';
                    message = 'Your score has been successfully saved';
                  } else {
                    title = 'Oops';
                    message =
                        'Your score hasn\'t been saved due to network problems';
                  }
                  showDialogAfterSaving(title, message);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
