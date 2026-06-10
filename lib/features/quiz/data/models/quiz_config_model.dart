import 'package:flutter_application_88/features/quiz/domain/entities/quiz_config.dart';

class QuizConfigModel extends QuizConfig {
  const QuizConfigModel({
    required int questionsCount,
    required String category,
    required String difficulty,
  }) : super(
          questionsCount: questionsCount,
          category: category,
          difficulty: difficulty,
        );

  factory QuizConfigModel.fromEntity(QuizConfig config) {
    return QuizConfigModel(
      questionsCount: config.questionsCount,
      category: config.category,
      difficulty: config.difficulty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionsCount': questionsCount,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory QuizConfigModel.fromJson(Map<String, dynamic> json) {
    return QuizConfigModel(
      questionsCount: json['questionsCount'] ?? 10,
      category: json['category'] ?? 'All',

      difficulty: json['difficulty'] ?? 'easy',
    );
  }
}