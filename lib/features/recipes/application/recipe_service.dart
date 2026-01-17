import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/recipe.dart';
import '../data/recipe_database.dart';
import '../../inventory/domain/entities/ingredient.dart';

final recipeListProvider = Provider<List<Recipe>>((ref) {
  return RecipeDatabase.initialRecipes;
});

final filteredRecipesProvider = Provider((ref) {
  final allRecipes = ref.watch(recipeListProvider);
  // Aquí se implementará la lógica de filtrado por ingredientes disponibles,
  // tiempo de preparación y región.
  return allRecipes;
});

class RecipeService {
  List<Recipe> filterByRegion(List<Recipe> recipes, String region) {
    if (region == 'Todas') return recipes;
    return recipes.where((r) => r.popularInCountry.contains(region)).toList();
  }

  List<Recipe> filterByTime(List<Recipe> recipes, bool fast) {
    if (fast) {
      return recipes.where((r) => r.preparationTimeMinutes <= 30).toList();
    } else {
      return recipes.where((r) => r.preparationTimeMinutes > 45).toList();
    }
  }

  List<Recipe> suggestRecipes(List<Recipe> allRecipes, List<Ingredient> availableIngredients) {
    // Lógica para priorizar recetas con más ingredientes disponibles
    return allRecipes; 
  }
}
