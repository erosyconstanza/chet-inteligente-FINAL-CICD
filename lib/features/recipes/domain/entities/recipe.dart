import '../../../inventory/domain/entities/ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<Ingredient> requiredIngredients;
  final List<String> steps;
  final int preparationTimeMinutes;
  final bool isSweet;
  final String popularInCountry;
  final String? imageUrl;
  final String difficulty;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.requiredIngredients,
    required this.steps,
    required this.preparationTimeMinutes,
    required this.isSweet,
    required this.popularInCountry,
    this.imageUrl,
    required this.difficulty,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      requiredIngredients: List<Ingredient>.from(
        (map['requiredIngredients'] ?? []).map((x) => Ingredient.fromMap(x)),
      ),
      steps: List<String>.from(map['steps'] ?? []),
      preparationTimeMinutes: map['preparationTimeMinutes'] ?? 0,
      isSweet: map['isSweet'] ?? false,
      popularInCountry: map['popularInCountry'] ?? '',
      imageUrl: map['imageUrl'],
      difficulty: map['difficulty'] ?? 'Media',
    );
  }
}
