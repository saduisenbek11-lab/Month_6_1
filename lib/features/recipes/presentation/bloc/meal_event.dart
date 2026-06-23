import 'package:equatable/equatable.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object?> get props => [];
}

class LoadMeals extends MealEvent {}

class SearchByTitleEvent extends MealEvent {
  final String query;

  const SearchByTitleEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchByIngredientsEvent extends MealEvent {
  final String ingredientsText;

  const SearchByIngredientsEvent(this.ingredientsText);

  @override
  List<Object?> get props => [ingredientsText];
}

class ToggleMealFavoriteEvent extends MealEvent {
  final String mealId;

  const ToggleMealFavoriteEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

class ToggleOnlyFavoritesEvent extends MealEvent {
  final bool onlyFavorites;

  const ToggleOnlyFavoritesEvent(this.onlyFavorites);

  @override
  List<Object?> get props => [onlyFavorites];
}

class SelectCategoryEvent extends MealEvent {
  final String? category;

  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class RepeatSearchEvent extends MealEvent {
  final String query;

  const RepeatSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}
