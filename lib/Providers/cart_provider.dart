import 'package:flutter/material.dart';
import 'package:pet_paradise/models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<CartProduct> cartList = [];

  void addToCart(CartProduct product) {
    cartList.add(product);
    notifyListeners();
  }

  void removeFromCart(CartProduct product) {
    cartList.remove(product);
    notifyListeners();
  }
}
