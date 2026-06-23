import '../entities/idea.dart';
import '../repositories/idea_repository.dart';

class SearchIdeas {
  final IdeaRepository repository;

  SearchIdeas(this.repository);

  Future<List<Idea>> call(String query) async {
    return repository.searchIdeas(query);
  }
}
