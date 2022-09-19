import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/logic/controllers/question.dart';
import 'package:quiz/utils/colors.dart';

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    super.key,
    required this.text,
    required this.index,
  });

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (QuestionController c) {
      Color getOptionColor() {
        if (c.answerResult.value == AnswerResult.notAnsweredYet) {
          return AppColors.darkBlue;
        }
        if (c.currentQuestion.correctAnswers.contains(text)) {
          return AppColors.green;
        } else {
          return AppColors.red;
        }
      }

      return Obx(() {
        return Container(
          color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: MaterialButton(
                  minWidth: 99999,
                  padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: getOptionColor(),
                  child: Text(
                          text,
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                  onPressed: () {
                    if (c.answerResult.value != AnswerResult.notAnsweredYet) {
                      return;
                    }
                    if (!c.chosenAnswers.contains(text)) {
                      c.choseAnswer(text);
                    } else {
                      c.unchooseAnswer(text);
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Icon(
                  c.chosenAnswers.contains(text) ? Icons.check_circle : Icons.circle_outlined,
                  color: AppColors.white,
                ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
