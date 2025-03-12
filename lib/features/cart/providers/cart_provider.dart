import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartProvider extends ChangeNotifier {
  // List of cart items
  List<CartItem> cartItems = [];

  // Add product to cart
  void addToCart(Product product) {
    // Check if the product already exists in the cart
    final existingItem = cartItems.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    // If product exists, increase the quantity, otherwise add new product to the cart
    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    // Notify listeners to update UI
    notifyListeners();
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Get total price of the cart
  double get totalPrice {
    return cartItems.fold(0, (total, item) => total + item.product.price * item.quantity);
  }

  // Get total item count in the cart
  int get itemCount {
    return cartItems.fold(0, (total, cartItem) => total + cartItem.quantity);
  }
}
