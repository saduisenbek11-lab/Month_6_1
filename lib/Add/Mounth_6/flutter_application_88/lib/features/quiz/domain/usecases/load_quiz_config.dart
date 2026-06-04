import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_config.dart';
import '../repositories/quiz_repository.dart';

class LoadQuizConfig implements UseCase<QuizConfig, NoParams> {
  final QuizRepository repository;

  LoadQuizConfig(this.repository);

  @override
  Future<QuizConfig> call(NoParams params) {
    return repository.loadQuizConfig();
  }
}
