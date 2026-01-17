import 'package:flutter/material.dart';

class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final String? imageUrl;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'imageUrl': imageUrl,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: (map['quantity'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  Ingredient copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    String? imageUrl,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
