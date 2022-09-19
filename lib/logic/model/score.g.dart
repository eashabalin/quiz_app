// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      id: json['id'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      datetime: json['datetime'] as Timestamp,
      questionsCount: json['questions_count'] as int,
      correctAnswers: json['correct_answers'] as int,
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'datetime': instance.datetime,
      'questions_count': instance.questionsCount,
      'correct_answers': instance.correctAnswers,
    };
