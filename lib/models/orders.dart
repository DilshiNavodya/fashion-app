import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String id;
  final int quantity, cost;

  static var order;
  Order({
    this.id,
    this.quantity,
    this.cost,
  });
}

List<Order> order = [];
