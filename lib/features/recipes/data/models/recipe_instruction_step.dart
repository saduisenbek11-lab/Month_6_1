class RecipeInstructionStep {
  final int number;
  final String text;
  final List<RecipeStepAsset> ingredients;
  final List<RecipeStepAsset> equipment;

  const RecipeInstructionStep({
    required this.number,
    required this.text,
    required this.ingredients,
    required this.equipment,
  });

  List<String> get imageUrls {
    return [
      ...ingredients.map((item) => item.imageUrl),
      ...equipment.map((item) => item.imageUrl),
    ].where((url) => url.isNotEmpty).toList(growable: false);
  }

  factory RecipeInstructionStep.fromJson(Map<String, dynamic> json) {
    return RecipeInstructionStep(
      number: json['number'] as int? ?? 0,
      text: json['step']?.toString() ?? '',
      ingredients: _parseAssets(
        json['ingredients'],
        RecipeStepAssetType.ingredient,
      ),
      equipment: _parseAssets(json['equipment'], RecipeStepAssetType.equipment),
    );
  }

  static List<RecipeStepAsset> _parseAssets(
    Object? value,
    RecipeStepAssetType type,
  ) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map((item) => RecipeStepAsset.fromJson(item, type))
        .toList(growable: false);
  }
}

enum RecipeStepAssetType { ingredient, equipment }

class RecipeStepAsset {
  final String name;
  final String imageName;
  final RecipeStepAssetType type;

  const RecipeStepAsset({
    required this.name,
    required this.imageName,
    required this.type,
  });

  String get imageUrl {
    if (imageName.isEmpty) {
      return '';
    }

    return switch (type) {
      RecipeStepAssetType.ingredient =>
        'https://img.spoonacular.com/ingredients_100x100/$imageName',
      RecipeStepAssetType.equipment =>
        'https://spoonacular.com/cdn/equipment_100x100/$imageName',
    };
  }

  factory RecipeStepAsset.fromJson(
    Map<String, dynamic> json,
    RecipeStepAssetType type,
  ) {
    return RecipeStepAsset(
      name: json['name']?.toString() ?? '',
      imageName: json['image']?.toString() ?? '',
      type: type,
    );
  }
}
