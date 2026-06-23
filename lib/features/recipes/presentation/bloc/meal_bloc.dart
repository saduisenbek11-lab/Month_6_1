import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/meal_model.dart';
import '../../domain/repositories/meal_repository.dart';
import 'meal_event.dart';
import 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository repository;

  MealBloc({required this.repository}) : super(MealState.initial()) {
    on<LoadMeals>(_onLoadMeals);
    on<SearchByTitleEvent>(_onSearchByTitle);
    on<SearchByIngredientsEvent>(_onSearchByIngredients);
    on<ToggleMealFavoriteEvent>(_onToggleFavorite);
    on<ToggleOnlyFavoritesEvent>(_onToggleOnlyFavorites);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<RepeatSearchEvent>(_onRepeatSearch);
  }

  Future<void> _onLoadMeals(LoadMeals event, Emitter<MealState> emit) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final meals = await repository.getAllMeals();
      emit(state.copyWith(
        meals: meals,
        visibleMeals: _applyFilters(meals),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSearchByTitle(SearchByTitleEvent event, Emitter<MealState> emit) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final meals = await repository.searchMeals(event.query);
      final next = state.copyWith(meals: meals, titleQuery: event.query);
      emit(next.copyWith(visibleMeals: _applyFilters(meals, next), isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка поиска'));
    }
  }

  Future<void> _onSearchByIngredients(SearchByIngredientsEvent event, Emitter<MealState> emit) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final meals = await repository.searchMealsByIngredients(event.ingredientsText);
      final next = state.copyWith(meals: meals, ingredientsText: event.ingredientsText);
      emit(next.copyWith(visibleMeals: _applyFilters(meals, next), isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка поиска по ингредиентам'));
    }
  }

  Future<void> _onToggleFavorite(ToggleMealFavoriteEvent event, Emitter<MealState> emit) async {
    final updated = state.meals.map((meal) {
      if (meal.id == event.mealId) {
        return meal.copyWith(isFavorite: !meal.isFavorite);
      }
      return meal;
    }).toList();

    final next = state.copyWith(meals: updated);
    emit(next.copyWith(visibleMeals: _applyFilters(updated, next)));
  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<MealState> emit) {
    final next = state.copyWith(
      selectedCategory: event.category,
      clearCategory: event.category == null,
    );
    emit(next.copyWith(visibleMeals: _applyFilters(next.meals, next)));
  }

  void _onToggleOnlyFavorites(ToggleOnlyFavoritesEvent event, Emitter<MealState> emit) {
    final next = state.copyWith(onlyFavorites: event.onlyFavorites);
    emit(next.copyWith(visibleMeals: _applyFilters(next.meals, next)));
  }

  void _onRepeatSearch(RepeatSearchEvent event, Emitter<MealState> emit) {
    add(SearchByIngredientsEvent(event.query));
  }

  List<MealShort> _applyFilters(List<MealShort> meals, [MealState? custom]) {
    final s = custom ?? state;
    return meals.where((meal) {
      if (s.onlyFavorites && !meal.isFavorite) return false;
      if (s.selectedCategory != null && s.selectedCategory!.isNotEmpty) {
        if (meal.category != s.selectedCategory) return false;
      }
      return true;
    }).toList();
  }
}
