import 'package:equatable/equatable.dart';

import '../../domain/entities/idea.dart';

abstract class IdeaEvent extends Equatable {
  const IdeaEvent();

  @override
  List<Object?> get props => [];
}

class LoadIdeas extends IdeaEvent {
  const LoadIdeas();
}

class AddIdeaEvent extends IdeaEvent {
  final Idea idea;

  const AddIdeaEvent(this.idea);

  @override
  List<Object?> get props => [idea];
}

class SearchIdeasEvent extends IdeaEvent {
  final String query;

  const SearchIdeasEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleFavoriteEvent extends IdeaEvent {
  final String ideaId;

  const ToggleFavoriteEvent(this.ideaId);

  @override
  List<Object?> get props => [ideaId];
}

class FilterFavoritesEvent extends IdeaEvent {
  final bool onlyFavorites;

  const FilterFavoritesEvent(this.onlyFavorites);

  @override
  List<Object?> get props => [onlyFavorites];
}

class UpdateIdeaEvent extends IdeaEvent {
  final Idea idea;

  const UpdateIdeaEvent(this.idea);

  @override
  List<Object?> get props => [idea];
}
