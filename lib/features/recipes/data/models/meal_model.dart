class MealShort {
  final String id;
  final String name;
  final String thumbnail;
  final String? category;
  final bool isFavorite;

  MealShort({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    this.isFavorite = false,
  });

  factory MealShort.fromJson(Map<String, dynamic> json) {
    return MealShort(
      id: (json['idMeal'] ?? json['id'] ?? '').toString(),
      name: (json['strMeal'] ?? json['title'] ?? '').toString(),
      thumbnail: (json['strMealThumb'] ?? json['image'] ?? '').toString(),
      category: json['strCategory'],
    );
  }

  MealShort copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? category,
    bool? isFavorite,
  }) {
    return MealShort(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;
  final List<String> measures;
  final bool isFavorite;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    required this.measures,
    this.isFavorite = false,
  });

  MealDetail copyWith({
    String? id,
    String? name,
    String? category,
    String? area,
    String? instructions,
    String? thumbnail,
    List<String>? ingredients,
    List<String>? measures,
    bool? isFavorite,
  }) {
    return MealDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      area: area ?? this.area,
      instructions: instructions ?? this.instructions,
      thumbnail: thumbnail ?? this.thumbnail,
      ingredients: ingredients ?? this.ingredients,
      measures: measures ?? this.measures,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    // Парсинг для TheMealDB (strIngredient1...20)
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString());
        measures.add(measure?.toString() ?? '');
      }
    }

    return MealDetail(
      id: (json['idMeal'] ?? json['id'] ?? '').toString(),
      name: (json['strMeal'] ?? json['title'] ?? '').toString(),
      category: (json['strCategory'] ?? '').toString(),
      area: (json['strArea'] ?? '').toString(),
      instructions: (json['strInstructions'] ?? json['summary'] ?? '').toString(),
      thumbnail: (json['strMealThumb'] ?? json['image'] ?? '').toString(),
      ingredients: ingredients,
      measures: measures,
    );
  }
}
