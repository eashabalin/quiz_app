import 'package:get/get.dart';
import 'package:quiz/repository/firestore.dart';
import 'package:quiz/logic/model/score.dart';

class ScoreController extends GetxController {
  final FirestoreDB _firestoreDB = FirestoreDB();
  RxList<Score> scores = <Score>[].obs;
  RxBool connectionProblem = false.obs;

  @override
  void onInit() {
    super.onInit();

    getScores();
  }

  Future<void> getScores() async {
    List<Score>? scoresFromFirestore = await _firestoreDB.getScores();
    if (scoresFromFirestore != null) {
      scores.value = scoresFromFirestore;
      scores.sort((a, b) => b.datetime.compareTo(a.datetime));
    } else {
      connectionProblem.value = true;
    }
  }
}
