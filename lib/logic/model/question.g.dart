// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      question: json['question'] as String,
      description: json['description'] as String?,
      answersJson: (json['answers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as String?),
      ),
      multipleCorrectAnswers: (json['multiple_correct_answers'] as String).toLowerCase() == 'true',
      correctAnswersJson: (json['correct_answers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e.toLowerCase() == 'true'),
      ),
      explanation: json['explanation'] as String?,
      tip: json['tip'] as String?,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
    );
