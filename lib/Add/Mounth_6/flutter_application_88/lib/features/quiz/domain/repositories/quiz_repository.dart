import '../entities/quiz_config.dart';

abstract class QuizRepository {
  Future<QuizConfig> loadQuizConfig();
  Future<void> saveQuizConfig(QuizConfig config);
}
