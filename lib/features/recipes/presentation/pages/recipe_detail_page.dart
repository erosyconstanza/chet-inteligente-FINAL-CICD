import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe.dart';
import '../../../inventory/domain/entities/ingredient.dart';
import '../../../inventory/application/inventory_service.dart';
import '../../../profile/application/profile_service.dart';
import '../../../profile/domain/entities/journal_entry.dart';
import 'package:uuid/uuid.dart';

class RecipeDetailPage extends ConsumerStatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
  });

  @override
  ConsumerState<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends ConsumerState<RecipeDetailPage> {
  int _servings = 2;

  void _cookNow() {
    // Restar de la despensa
    ref.read(inventoryProvider.notifier).deductIngredients(widget.recipe.requiredIngredients, _servings);
    
    // Mostrar snackbar de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Chef! Ingredientes descontados de tu despensa.')),
    );

    // Abrir diálogo de diario opcional
    _showJournalDialog();
  }

  void _showJournalDialog() {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Registrar en tu diario?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Guarda una nota y foto de tu resultado final.'),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: 'Ej: ¡Me quedó genial! Cena con amigos.',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ahora no')),
          ElevatedButton(
            onPressed: () {
              ref.read(profileProvider.notifier).addJournalEntry(
                JournalEntry(
                  id: const Uuid().v4(),
                  recipeName: widget.recipe.name,
                  recipeId: widget.recipe.id,
                  imageUrl: widget.recipe.imageUrl ?? '',
                  note: noteController.text,
                  date: DateTime.now(),
                ),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Añadido a tu Diario Gastronómico')),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInventory = ref.watch(inventoryProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.recipe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  widget.recipe.imageUrl != null
                      ? Image.network(widget.recipe.imageUrl!, fit: BoxFit.cover)
                      : Container(color: Colors.grey[400]),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickInfo(context),
                    const Divider(height: 48),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('¿Para cuántos?', style: Theme.of(context).textTheme.titleLarge),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => setState(() => _servings = _servings > 1 ? _servings - 1 : 1),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('$_servings', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => setState(() => _servings++),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text('Descripción', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(widget.recipe.description, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 32),
                    
                    Text('Ingredientes', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    _buildIngredientsList(context, userInventory),
                    const SizedBox(height: 32),
                    
                    Text('Preparación', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _buildStepsList(context),
                    
                    const SizedBox(height: 48),
                    ElevatedButton(
                      onPressed: _cookNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('¡Cocinada! Descontar Despensa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _infoTile(Icons.timer_outlined, 'Tiempo', '${widget.recipe.preparationTimeMinutes} min'),
        _infoTile(Icons.bolt, 'Dificultad', widget.recipe.difficulty),
        _infoTile(Icons.public, 'Origen', widget.recipe.popularInCountry),
      ],
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildIngredientsList(BuildContext context, List<Ingredient> inventory) {
    return Column(
      children: widget.recipe.requiredIngredients.map((ingredient) {
        final bool isAvailable = inventory.any((i) => i.name.toLowerCase() == ingredient.name.toLowerCase() && i.quantity > 0);
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            isAvailable ? Icons.check_circle_outline : Icons.error_outline,
            color: isAvailable ? Colors.green : Colors.red,
          ),
          title: Text(ingredient.name),
          trailing: Text(
            '${(ingredient.quantity / 2 * _servings).toStringAsFixed(1)} ${ingredient.unit}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStepsList(BuildContext context) {
    return Column(
      children: widget.recipe.steps.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${entry.key + 1}',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 16, height: 1.5))),
            ],
          ),
        );
      }).toList(),
    );
  }
}
