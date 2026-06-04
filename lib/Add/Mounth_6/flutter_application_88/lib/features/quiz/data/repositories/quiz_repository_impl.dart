import '../../domain/entities/quiz_config.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../models/quiz_config_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizConfigModel _cachedConfig = const QuizConfigModel(
    questionsCount: 10,
    category: 'All',
    difficulty: 'All',
  );

  @override
  Future<QuizConfig> loadQuizConfig() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _cachedConfig;
  }

  @override
  Future<void> saveQuizConfig(QuizConfig config) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _cachedConfig = QuizConfigModel.fromEntity(config);
  }
}
