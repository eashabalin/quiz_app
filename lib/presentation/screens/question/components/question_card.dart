import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/logic/controllers/question.dart';
import 'package:quiz/logic/model/question.dart';
import 'package:quiz/presentation/screens/question/components/answer_option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    final QuestionController c = Get.find();

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  question.question,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: c.currentQuestion.multipleCorrectAnswers,
                  child: const Text(
                    '(Multiple choice)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: question.answers.length,
            itemBuilder: (context, index) {
              return AnswerOption(
                text: question.answers[index],
                index: index,
              );
            },
            separatorBuilder: (context, count) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
        ],
      ),
    );
  }
}
