import 'package:flutter/material.dart';

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


class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

class CartProvider extends ChangeNotifier {
  void addItem(CartItem item) {
    debugPrint('${item.name} ditambahkan ke keranjang.');
    notifyListeners();
  }
}
