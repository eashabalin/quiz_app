import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/presentation/screens/scores/scores.dart';
import 'package:quiz/utils/colors.dart';

import '../../../logic/controllers/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() {
                return const ScoresScreen();
              });
            },
            icon: Icon(
              Icons.menu,
              color: AppColors.darkBlue,
            ),
          )
        ],
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose category:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              return ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: c.chosenCategory.value,
                  isExpanded: true,
                  items: c.categoryOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      c.chosenCategory.value = value;
                    }
                  },
                ),
              );
            }),
            const Padding(padding: EdgeInsets.only(top: 8)),
            const Text(
              'Choose difficulty:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              return ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: c.chosenDifficulty.value,
                  isExpanded: true,
                  items: c.difficultyOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      c.chosenDifficulty.value = value;
                    }
                  },
                ),
              );
            }),
            const Padding(padding: EdgeInsets.only(top: 16)),
            MaterialButton(
              color: AppColors.darkBlue,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Go!',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                c.startQuiz();
              },
            ),
          ],
        ),
      ),
    );
  }
}
