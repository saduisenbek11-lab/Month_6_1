import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_config.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizConfig implements UseCase<void, QuizConfig> {
  final QuizRepository repository;

  SaveQuizConfig(this.repository);

  @override
  Future<void> call(QuizConfig params) {
    return repository.saveQuizConfig(params);
  }
}
