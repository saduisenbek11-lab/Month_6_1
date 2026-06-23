import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/features/recipes/domain/repositories/meal_repository.dart';
import '../models/meal_model.dart';
import '../models/recipe_instruction_step.dart';

// Репозиторий для работы с API рецептов
class MealRepositoryImpl implements MealRepository {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  
  static const String _spoonacularBaseUrl = 'https://api.spoonacular.com/recipes';
  static const String _spoonacularApiKey = String.fromEnvironment('SPOONACULAR_API_KEY');

  @override
  Future<List<MealShort>> searchMeals(String query) async {
    final trimmedQuery = _translateQuery(query.trim());
    if (trimmedQuery.isEmpty) {
      return getAllMeals();
    }

    final response = await _getRaw('search.php', {'s': trimmedQuery});
    return _parseShortMeals(response);
  }

  @override
  Future<List<MealShort>> getAllMeals() async {
    final response = await _getRaw('search.php', {'s': 'chicken'});
    return _parseShortMeals(response)
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<MealDetail> getMealById(String id) async {
    final response = await _getRaw('lookup.php', {'i': id});
    final data = jsonDecode(response.body);
    final meals = data['meals'];

    if (meals == null || (meals as List).isEmpty) {
      throw Exception('Рецепт не найден');
    }

    return MealDetail.fromJson(meals.first as Map<String, dynamic>);
  }

  @override
  Future<List<MealShort>> searchMealsByIngredients(String ingredientsText) async {
    final ingredients = ingredientsText
        .split(',')
        .map((item) => _translateQuery(item.trim()))
        .where((item) => item.isNotEmpty)
        .toList();

    if (ingredients.isEmpty) {
      return getAllMeals();
    }

    final response = await _getRaw('filter.php', {'i': ingredients.first});
    return _parseShortMeals(response);
  }

  @override
  Future<List<RecipeInstructionStep>> getSpoonacularInstructionSteps({
    String? recipeId,
  }) async {
    final id = recipeId ?? '324694';
    if (_spoonacularApiKey.isEmpty) return const [];

    final response = await http.get(
      Uri.parse('$_spoonacularBaseUrl/$id/analyzedInstructions').replace(
        queryParameters: {
          'stepBreakdown': 'true',
          'apiKey': _spoonacularApiKey,
        },
      ),
    );

    if (response.statusCode != 200) return const [];

    final decoded = jsonDecode(response.body);
    if (decoded is! List || decoded.isEmpty) return const [];

    final steps = decoded.first['steps'];
    if (steps is! List) return const [];

    return steps
        .whereType<Map<String, dynamic>>()
        .map(RecipeInstructionStep.fromJson)
        .toList();
  }

  Future<http.Response> _getRaw(String path, Map<String, String> params) async {
    final uri = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки данных');
    }
    return response;
  }

  List<MealShort> _parseShortMeals(http.Response response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final meals = data['meals'];
    if (meals == null) return [];

    return (meals as List)
        .map((m) => MealShort.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  String _translateQuery(String value) {
    final normalized = value.toLowerCase();
    return _queryTranslations[normalized] ?? value;
  }
}

const _queryTranslations = {
  'говядина': 'beef',
  'курица': 'chicken',
  'мясо': 'meat',
  'рыба': 'fish',
  'сыр': 'cheese',
  'помидор': 'tomato',
  'картофель': 'potato',
  'рис': 'rice',
  'яйцо': 'egg',
};
