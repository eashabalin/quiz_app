import 'package:dio/dio.dart';
import 'package:quiz/logic/model/question.dart';

class QuizAPI {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://quizapi.io/api/v1/questions';
  final String _apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';

  Future<List<Question>> getQuestions(
      {required String category,
      required String difficulty,
      required int limit}) async {
    List<Question> questions = [];
    try {
      Map<String, dynamic> params = {
        'apiKey': _apiKey,
        'category': category,
        'difficulty': difficulty,
        'limit': limit,
      };
      Response response = await _dio.get(_baseUrl, queryParameters: params);
      for (Map<String, dynamic> map in response.data) {
        questions.add(Question.fromJson(map));
      }
    } on DioError catch (e) {
      print(e);
    }
    return questions;
  }
}
