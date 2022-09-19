import 'package:flutter/material.dart';
import 'package:quiz/logic/controllers/question.dart';
import 'package:get/get.dart';
import 'package:quiz/presentation/screens/home/home.dart';
import 'package:quiz/presentation/screens/question/components/question_card.dart';
import 'package:quiz/utils/colors.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionController c = Get.put(QuestionController());

    Text getButtonText() {
      Color textColor = AppColors.white;
      double fontSize = 16;
      if (c.chosenAnswers.isEmpty) {
        textColor = AppColors.grey;
      }
      if (c.answerResult.value == AnswerResult.notAnsweredYet) {
        return Text(
          'Check',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        );
      } else {
        if (c.questionNumber.value < c.questions.length) {
          return Text(
            'Next',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          );
        } else {
          return Text(
            'Finish',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          );
        }
      }
    }

    void Function()? onButtonPressed() {
      if (c.chosenAnswers.isNotEmpty) {
        return () {
          if (c.answerResult.value == AnswerResult.notAnsweredYet) {
            c.checkAnswers();
          } else {
            if (c.questionNumber.value == c.questions.length) {
              c.finishQuiz();
            }
            c.goToNextQuestion();
          }
        };
      } else {
        return null;
      }
    }

    Future<void> showQuitDialog() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm exit'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const [
                  Text('Do you really want to quit?'),
                  Text('Your progress won\'t be saved.')
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.darkBlue),
                ),
                onPressed: () {
                  Get.offAll(const HomeScreen());
                },
                child: const Text('Quit'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.darkBlue),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx((() {
          return Text(
            'Question ${c.questionNumber}',
            style: TextStyle(
              color: AppColors.black,
            ),
          );
        })),
        backgroundColor: AppColors.white,
        leading: BackButton(
          color: AppColors.darkBlue,
          onPressed: () {
            showQuitDialog();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (c.questions.isEmpty) {
              return CircularProgressIndicator(
                color: AppColors.darkBlue,
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: c.pageController,
                        itemCount: c.questions.length,
                        itemBuilder: (contex, index) {
                          return QuestionCard(question: c.questions[index]);
                        },
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MaterialButton(
                    color: AppColors.darkBlue,
                    onPressed: onButtonPressed(),
                    child: getButtonText(),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
