import 'package:equatable/equatable.dart';

import '../../domain/entities/idea.dart';

class IdeaState extends Equatable {
  final List<Idea> ideas;
  final List<Idea> filteredIdeas;
  final String searchQuery;
  final bool onlyFavorites;

  const IdeaState({
    required this.ideas,
    required this.filteredIdeas,
    required this.searchQuery,
    required this.onlyFavorites,
  });

  factory IdeaState.initial() {
    return const IdeaState(
      ideas: [],
      filteredIdeas: [],
      searchQuery: '',
      onlyFavorites: false,
    );
  }

  IdeaState copyWith({
    List<Idea>? ideas,
    List<Idea>? filteredIdeas,
    String? searchQuery,
    bool? onlyFavorites,
  }) {
    return IdeaState(
      ideas: ideas ?? this.ideas,
      filteredIdeas: filteredIdeas ?? this.filteredIdeas,
      searchQuery: searchQuery ?? this.searchQuery,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
    );
  }

  @override
  List<Object?> get props => [ideas, filteredIdeas, searchQuery, onlyFavorites];
}
