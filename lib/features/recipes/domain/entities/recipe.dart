import 'package:equatable/equatable.dart';

enum RecipeCategory { breakfast, lunch, dinner, dessert }

extension RecipeCategoryLabel on RecipeCategory {
  String get label {
    switch (this) {
      case RecipeCategory.breakfast:
        return 'Завтрак';
      case RecipeCategory.lunch:
        return 'Обед';
      case RecipeCategory.dinner:
        return 'Ужин';
      case RecipeCategory.dessert:
        return 'Десерт';
    }
  }
}

class Recipe extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int cookingTimeMinutes;
  final int servings;
  final int calories;
  final RecipeCategory category;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.cookingTimeMinutes,
    required this.servings,
    required this.calories,
    required this.category,
    this.isFavorite = false,
  });

  Recipe copyWith({bool? isFavorite}) {
    return Recipe(
      id: id,
      title: title,
      imageUrl: imageUrl,
      ingredients: ingredients,
      steps: steps,
      cookingTimeMinutes: cookingTimeMinutes,
      servings: servings,
      calories: calories,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    ingredients,
    steps,
    cookingTimeMinutes,
    servings,
    calories,
    category,
    isFavorite,
  ];
}
