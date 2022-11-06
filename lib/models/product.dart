import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String image, title, description, price, type, id;

  static var product;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.type,
  });
}
