import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/inventory_service.dart';
import '../../domain/entities/shopping_item.dart';

class ShoppingListPage extends ConsumerWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simulamos una lista de compras basada en lo que falta
    final inventory = ref.watch(inventoryProvider);
    final missingItems = [
      'Sal', 'Pimienta', 'Aceite de Oliva', 'Ajo'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: missingItems.isEmpty
          ? const Center(child: Text('Tu lista de compras está vacía'))
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: missingItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart_outlined),
                    title: Text(missingItems[index]),
                    trailing: Checkbox(
                      value: false,
                      onChanged: (val) {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
