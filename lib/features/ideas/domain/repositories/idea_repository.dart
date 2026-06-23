import '../entities/idea.dart';

abstract class IdeaRepository {
  Future<List<Idea>> getIdeas();
  Future<void> addIdea(Idea idea);
  Future<List<Idea>> searchIdeas(String query);
  Future<void> toggleFavorite(String ideaId);
  Future<void> updateIdea(Idea idea);
}
