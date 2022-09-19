import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/logic/controllers/score.dart';
import 'package:quiz/presentation/screens/home/home.dart';
import 'package:quiz/utils/colors.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScoreController c = Get.put(ScoreController());

    String getNiceDateString(Timestamp timestamp) {
      String date = timestamp.toDate().toIso8601String().split('T')[0];
      return date.replaceAll(RegExp(r'-'), '.');
    }

    String getNiceTimeString(Timestamp timestamp) {
      String time = timestamp.toDate().toIso8601String().split('T')[1];
      return time.substring(0, 5);
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColors.darkBlue),
        backgroundColor: AppColors.white,
        title: Text(
          'Scores',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(() {
            if (c.scores.isEmpty) {
              return CircularProgressIndicator(
                color: AppColors.darkBlue,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              itemCount: c.scores.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
              itemBuilder: ((context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(66, 0, 0, 0),
                        offset: Offset(
                          0.0,
                          2.0,
                        ),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${c.scores[index].correctAnswers}/${c.scores[index].questionsCount}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          '${c.scores[index].category.capitalizeFirst ??
                              c.scores[index].category} | ${c.scores[index].difficulty.capitalizeFirst ??
                              c.scores[index].difficulty}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          getNiceDateString(c.scores[index].datetime),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          getNiceTimeString(c.scores[index].datetime),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
