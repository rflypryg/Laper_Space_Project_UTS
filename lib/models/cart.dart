// lib/models/cart.dart

import 'package:flutter/material.dart';
// Note: Jangan lupa 'flutter pub get' untuk paket provider!

class CartItem {
  final String name;
  final double price;
  int quantity;
  
  CartItem({
    required this.name, 
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CartItem newItem) {
    int existingIndex = _items.indexWhere((i) => i.name == newItem.name);
    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }
  
  void updateQuantity(String name, int newQuantity) {
    int index = _items.indexWhere((i) => i.name == name);
    if (index != -1 && newQuantity > 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    } else if (newQuantity == 0) {
      removeItem(name);
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}