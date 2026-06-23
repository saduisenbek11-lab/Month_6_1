import 'package:equatable/equatable.dart';
import '../../data/models/meal_model.dart';

class MealState extends Equatable {
  final List<MealShort> meals;
  final List<MealShort> visibleMeals;

  final List<String> searchHistory;

  final String ingredientsText;
  final String titleQuery;

  final String? selectedCategory;
  final bool onlyFavorites;
  final bool isLoading;
  final String? errorMessage;

  const MealState({
    required this.meals,
    required this.visibleMeals,
    required this.searchHistory,
    required this.ingredientsText,
    required this.titleQuery,
    required this.selectedCategory,
    required this.onlyFavorites,
    required this.isLoading,
    required this.errorMessage,
  });

  factory MealState.initial() {
    return const MealState(
      meals: [],
      visibleMeals: [],
      searchHistory: [],
      ingredientsText: '',
      titleQuery: '',
      selectedCategory: null,
      onlyFavorites: false,
      isLoading: false,
      errorMessage: null,
    );
  }

  MealState copyWith({
    List<MealShort>? meals,
    List<MealShort>? visibleMeals,
    List<String>? searchHistory,
    String? ingredientsText,
    String? titleQuery,
    String? selectedCategory,
    bool clearCategory = false,
    bool? onlyFavorites,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MealState(
      meals: meals ?? this.meals,
      visibleMeals: visibleMeals ?? this.visibleMeals,
      searchHistory: searchHistory ?? this.searchHistory,
      ingredientsText: ingredientsText ?? this.ingredientsText,
      titleQuery: titleQuery ?? this.titleQuery,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    meals,
    visibleMeals,
    searchHistory,
    ingredientsText,
    titleQuery,
    selectedCategory,
    onlyFavorites,
    isLoading,
    errorMessage,
  ];
}
