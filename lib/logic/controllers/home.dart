import 'package:get/get.dart';
import 'package:quiz/screens/question/question.dart';

class HomeController extends GetxController {
  RxList<String> categoryOptions = <String>[
    'Linux',
    'DevOps',
    'Docker',
  ].obs;
  RxList<String> difficultyOptions = <String>[
    'Easy',
    'Medium',
    'Hard',
  ].obs;

  RxString chosenCategory = 'Linux'.obs;
  RxString chosenDifficulty = 'Easy'.obs;

  void startQuiz() {
    Get.to(() {
      return const QuestionScreen();
    }, arguments: {
      'category': chosenCategory.value,
      'difficulty': chosenDifficulty.value,
    });
  }
}
