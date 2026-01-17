import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/inventory_service.dart';
import '../../domain/entities/ingredient.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(inventoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Despensa'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: ingredients.isEmpty
          ? const _EmptyInventoryView()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              itemCount: ingredients.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = ingredients[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (Theme.of(context).cardTheme.shape as RoundedRectangleBorder).side.color,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconForItem(item.name),
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.quantity.toStringAsFixed(1)} ${item.unit}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 20),
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  IconData _getIconForItem(String name) {
    final n = name.toLowerCase();
    if (n.contains('huevo')) return Icons.egg_outlined;
    if (n.contains('harina')) return Icons.bakery_dining_outlined;
    if (n.contains('leche')) return Icons.water_drop_outlined;
    if (n.contains('arroz')) return Icons.rice_bowl_outlined;
    if (n.contains('cebolla')) return Icons.spa_outlined;
    return Icons.inventory_2_outlined;
  }
}

class _EmptyInventoryView extends StatelessWidget {
  const _EmptyInventoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Theme.of(context).disabledColor),
          const SizedBox(height: 24),
          Text(
            'Tu despensa está vacía',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'Escanea productos para empezar',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
