import '../../../inventory/domain/entities/ingredient.dart';

class ShoppingItem {
  final Ingredient ingredient;
  final bool isChecked;

  ShoppingItem({
    required this.ingredient,
    this.isChecked = false,
  });

  ShoppingItem copyWith({
    Ingredient? ingredient,
    bool? isChecked,
  }) {
    return ShoppingItem(
      ingredient: ingredient ?? this.ingredient,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
