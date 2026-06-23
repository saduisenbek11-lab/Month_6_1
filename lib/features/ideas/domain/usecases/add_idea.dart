import '../entities/idea.dart';
import '../repositories/idea_repository.dart';

class AddIdea {
  final IdeaRepository repository;

  AddIdea(this.repository);

  Future<void> call(Idea idea) async {
    await repository.addIdea(idea);
  }
}
