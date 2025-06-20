import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Tambahan opsional: icon otomatis berdasarkan kategori
  IconData get icon {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.fastfood;
      case 'transportasi':
        return Icons.directions_bus;
      case 'hiburan':
        return Icons.movie;
      case 'belanja':
        return Icons.shopping_cart;
      case 'beasiswa':
        return Icons.school;
      default:
        return Icons.attach_money;
    }
  }
}
