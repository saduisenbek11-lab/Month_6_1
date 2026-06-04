// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HarryModel _$HarryModelFromJson(Map<String, dynamic> json) => HarryModel(
  category: json['category'] as String,
  question: json['question'] as String,
  correctAnswer: json['correct_answer'] as String,
  incorrectAnswers: (json['incorrect_answers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$HarryModelToJson(HarryModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'question': instance.question,
      'correct_answer': instance.correctAnswer,
      'incorrect_answers': instance.incorrectAnswers,
    };
