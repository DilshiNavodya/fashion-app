import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String image, title, price, id;

  static var cartItems;
  CartItem({
    this.id,
    this.image,
    this.title,
    this.price,
  });
}

List<CartItem> cartItems = [];
