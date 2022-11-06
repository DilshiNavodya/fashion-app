import 'package:fashion_app/models/orders.dart';
import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  final String pid, price;
  final int quantity;

  const CartCounter({Key key, this.pid, this.price, this.quantity})
      : super(key: key);
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  var pid;
  var price;
  void initState() {
    super.initState();
    pid = widget.pid;
    price = widget.price;
    numOfItems = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: IconButton(
            onPressed: () {
              if (numOfItems > 1) {
                setState(() {
                  numOfItems--;
                  print(numOfItems);
                });
              }
              for (int i = 0; i < order.length; i++) {
                if (order[i].id == pid) {
                  order.removeAt(i);
                }
              }
              order.add(Order(
                  id: pid,
                  quantity: numOfItems,
                  cost: int.parse(price) * numOfItems));
              print(order.length);
            },
            icon: const Icon(Icons.remove),
            iconSize: 15,
            padding: EdgeInsets.zero,
          ),
        ),
        Text(
          numOfItems.toString().padLeft(2, "0"),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: IconButton(
            onPressed: () {
              setState(() {
                numOfItems++;
                print(numOfItems);
              });
              for (int i = 0; i < order.length; i++) {
                if (order[i].id == pid) {
                  order.removeAt(i);
                }
              }
              order.add(Order(
                  id: pid,
                  quantity: numOfItems,
                  cost: int.parse(price) * numOfItems));
              print(order.length);
            },
            icon: const Icon(Icons.add),
            iconSize: 15,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
