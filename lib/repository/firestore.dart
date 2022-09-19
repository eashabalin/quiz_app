import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/logic/model/score.dart';

class FirestoreDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Score>?> getScores() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection('scores').get();
      List<Score> scores = querySnapshot.docs.map((e) {
        Map<String, dynamic> doc = e.data();
        doc['id'] = e.id;
        return Score.fromJson(doc);
      }).toList();
      return scores;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> saveScore(Score score) async {
    try {
      Map<String, dynamic> json = score.toJson();
      json.remove('id');
      DocumentReference<Map<String, dynamic>> doc =
          await _db.collection('scores').add(json);
      return doc.id;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
