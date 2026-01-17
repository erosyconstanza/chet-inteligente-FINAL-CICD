import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No tienes recetas favoritas aún'),
            SizedBox(height: 8),
            Text('¡Guarda las que más te gusten!', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
