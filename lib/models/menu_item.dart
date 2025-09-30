// lib/models/menu_item.dart
import 'package:flutter/material.dart';

// =========================================================
// 1. MODEL MENU ITEM
// =========================================================
class MenuItem {
  final String name;
  final String description; // Deskripsi singkat
  final String fullDescription; // Deskripsi lengkap
  final double price;
  final String imageUrl; // URL gambar (Network atau Asset Path)
  final String category;

  const MenuItem({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}


// =========================================================
// 2. MODEL CART/PROVIDER (Placeholder agar tidak error)
// =========================================================
class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

class CartProvider extends ChangeNotifier {
  // Hanya placeholder untuk memastikan MenuDetailScreen berjalan
  void addItem(CartItem item) {
    // Logika keranjang yang sebenarnya harus ada di sini
    debugPrint('${item.name} ditambahkan ke keranjang.');
    notifyListeners();
  }
}