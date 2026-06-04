import 'package:json_annotation/json_annotation.dart';

part 'harry_model.g.dart'; 

@JsonSerializable()
class HarryModel {
  final String category;
  final String question;
  
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  
  @JsonKey(name: 'incorrect_answers')
  final List<String> incorrectAnswers;

  HarryModel({
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory HarryModel.fromJson(Map<String, dynamic> json) => _$HarryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HarryModelToJson(this);
}