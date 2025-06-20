import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart'; // Wajib untuk adapter

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String category;

  @HiveField(4)
  DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

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
