import 'package:json_annotation/json_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'score.g.dart';

@JsonSerializable()
class Score {
  Score({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.datetime,
    required this.questionsCount,
    required this.correctAnswers,
  });

  String id;
  String category;
  String difficulty;
  Timestamp datetime;
  int questionsCount;
  int correctAnswers;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}
