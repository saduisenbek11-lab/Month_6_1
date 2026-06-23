import '../entities/idea.dart';
import '../repositories/idea_repository.dart';

class UpdateIdea {
  final IdeaRepository repository;

  UpdateIdea(this.repository);

  Future<void> call(Idea idea) async {
    await repository.updateIdea(idea);
  }
}
