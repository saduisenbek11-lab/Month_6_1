import '../entities/idea.dart';
import '../repositories/idea_repository.dart';

class GetIdeas {
  final IdeaRepository repository;

  GetIdeas(this.repository);

  Future<List<Idea>> call() async {
    return repository.getIdeas();
  }
}
