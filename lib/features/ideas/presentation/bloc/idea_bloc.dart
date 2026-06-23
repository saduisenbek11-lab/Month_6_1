import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/idea.dart';
import '../../domain/usecases/add_idea.dart';
import '../../domain/usecases/get_ideas.dart';
import '../../domain/usecases/search_ideas.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../domain/usecases/update_idea.dart';
import 'idea_event.dart';
import 'idea_state.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState> {
  final GetIdeas getIdeas;
  final AddIdea addIdea;
  final SearchIdeas searchIdeas;
  final ToggleFavorite toggleFavorite;
  final UpdateIdea updateIdea;

  IdeaBloc({
    required this.getIdeas,
    required this.addIdea,
    required this.searchIdeas,
    required this.toggleFavorite,
    required this.updateIdea,
  }) : super(IdeaState.initial()) {
    on<LoadIdeas>(_onLoadIdeas);
    on<AddIdeaEvent>(_onAddIdea);
    on<SearchIdeasEvent>(_onSearchIdeas);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<FilterFavoritesEvent>(_onFilterFavorites);
    on<UpdateIdeaEvent>(_onUpdateIdea);
  }

  Future<void> _onLoadIdeas(LoadIdeas event, Emitter<IdeaState> emit) async {
    final ideas = await getIdeas();
    emit(
      state.copyWith(
        ideas: ideas,
        filteredIdeas: _filterIdeas(
          ideas,
          state.searchQuery,
          state.onlyFavorites,
        ),
      ),
    );
  }

  Future<void> _onAddIdea(AddIdeaEvent event, Emitter<IdeaState> emit) async {
    await addIdea(event.idea);
    final ideas = await getIdeas();
    emit(
      state.copyWith(
        ideas: ideas,
        filteredIdeas: _filterIdeas(
          ideas,
          state.searchQuery,
          state.onlyFavorites,
        ),
      ),
    );
  }

  Future<void> _onSearchIdeas(
    SearchIdeasEvent event,
    Emitter<IdeaState> emit,
  ) async {
    final filteredIdeas = _filterIdeas(
      state.ideas,
      event.query,
      state.onlyFavorites,
    );
    emit(
      state.copyWith(searchQuery: event.query, filteredIdeas: filteredIdeas),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<IdeaState> emit,
  ) async {
    await toggleFavorite(event.ideaId);
    final ideas = await getIdeas();
    emit(
      state.copyWith(
        ideas: ideas,
        filteredIdeas: _filterIdeas(
          ideas,
          state.searchQuery,
          state.onlyFavorites,
        ),
      ),
    );
  }

  Future<void> _onFilterFavorites(
    FilterFavoritesEvent event,
    Emitter<IdeaState> emit,
  ) async {
    final filteredIdeas = _filterIdeas(
      state.ideas,
      state.searchQuery,
      event.onlyFavorites,
    );
    emit(
      state.copyWith(
        onlyFavorites: event.onlyFavorites,
        filteredIdeas: filteredIdeas,
      ),
    );
  }

  Future<void> _onUpdateIdea(
    UpdateIdeaEvent event,
    Emitter<IdeaState> emit,
  ) async {
    await updateIdea(event.idea);
    final ideas = await getIdeas();
    emit(
      state.copyWith(
        ideas: ideas,
        filteredIdeas: _filterIdeas(
          ideas,
          state.searchQuery,
          state.onlyFavorites,
        ),
      ),
    );
  }

  List<Idea> _filterIdeas(List<Idea> ideas, String query, bool onlyFavorites) {
    final normalized = query.toLowerCase();
    return ideas
        .where((idea) {
          if (onlyFavorites && !idea.isFavorite) return false;
          if (normalized.isEmpty) return true;
          final searchable =
              '${idea.title} ${idea.description} ${idea.category} ${idea.tags.join(' ')}'
                  .toLowerCase();
          return searchable.contains(normalized);
        })
        .toList(growable: false);
  }
}
