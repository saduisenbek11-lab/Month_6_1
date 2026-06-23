import '../repositories/idea_repository.dart';

class ToggleFavorite {
  final IdeaRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(String ideaId) async {
    await repository.toggleFavorite(ideaId);
  }
}
