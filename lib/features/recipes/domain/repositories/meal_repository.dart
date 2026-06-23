import 'package:project/features/recipes/data/models/meal_model.dart';
import 'package:project/features/recipes/data/models/recipe_instruction_step.dart';

abstract class MealRepository {
  Future<List<MealShort>> searchMeals(String query);

  Future<List<MealShort>> searchMealsByIngredients(String ingredientsText);

  Future<List<MealShort>> getAllMeals();

  Future<MealDetail> getMealById(String id);

  Future<List<RecipeInstructionStep>> getSpoonacularInstructionSteps({
    String recipeId,
  });
}
