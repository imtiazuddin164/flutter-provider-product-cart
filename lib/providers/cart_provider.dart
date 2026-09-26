import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Add product to cart
  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  // Remove product completely
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);

    notifyListeners();
  }

  // Clear entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Total number of products
  int get totalItems {
    int total = 0;

    for (final item in _cartItems) {
      total += item.quantity;
    }

    return total;
  }

  // Subtotal
  double get subtotal {
    double total = 0;

    for (final item in _cartItems) {
      total += item.totalPrice;
    }

    return total;
  }

  // Discount
  double get discount {
    if (subtotal > 2000) {
      return subtotal * 0.10;
    }

    return 0;
  }

  // Final total
  double get finalTotal {
    return subtotal - discount;
  }
}
