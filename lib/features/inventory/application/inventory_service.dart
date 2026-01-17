import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../domain/entities/ingredient.dart';

class InventoryNotifier extends StateNotifier<List<Ingredient>> {
  InventoryNotifier() : super(_initialInventory);

  static final List<Ingredient> _initialInventory = [
    Ingredient(id: '1', name: 'Huevos', quantity: 12, unit: 'unidades'),
    Ingredient(id: '2', name: 'Leche', quantity: 1, unit: 'litro'),
    Ingredient(id: '3', name: 'Harina', quantity: 1, unit: 'kg'),
    Ingredient(id: '4', name: 'Arroz', quantity: 1, unit: 'kg'),
    Ingredient(id: '5', name: 'Cebolla', quantity: 3, unit: 'unidades'),
  ];

  void addIngredient(Ingredient ingredient) {
    state = [...state, ingredient];
  }

  void deductIngredients(List<Ingredient> required, int servings) {
    final List<Ingredient> newState = [...state];
    for (var req in required) {
      final index = newState.indexWhere((i) => i.name.toLowerCase() == req.name.toLowerCase());
      if (index != -1) {
        final current = newState[index];
        final toDeduct = (req.quantity / 2) * servings; // Basado en porción base para 2
        final newQuantity = current.quantity - toDeduct;
        newState[index] = current.copyWith(quantity: newQuantity > 0 ? newQuantity : 0);
      }
    }
    state = newState;
  }
}

final inventoryProvider = StateNotifierProvider<InventoryNotifier, List<Ingredient>>((ref) {
  return InventoryNotifier();
});
