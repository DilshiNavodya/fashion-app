import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/models/cartItem.dart';
import 'package:fashion_app/models/orders.dart';
import 'package:fashion_app/screens/bottom_nav_controller.dart';
import 'package:fashion_app/screens/components/details/cart_counter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final ValueNotifier<int> _totalPrice = ValueNotifier<int>(0);
  List<int> numOfItems = [0];

  @override
  Widget build(BuildContext context) {
    _totalPrice.value = 0;
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              numOfItems.insert(index, order[index].quantity);
              Future.delayed(Duration.zero, () {
                _totalPrice.value = _totalPrice.value + order[index].cost;
              });
              return Card(
                  color: Colors.blueGrey.shade200,
                  elevation: 5.0,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                cartItems[index].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text: cartItems[index].title,
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      text: 'Rs.${cartItems[index].price}',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: IconButton(
                                    onPressed: () {
                                      print(order[index].quantity);
                                      print("l");
                                      print(numOfItems[index]);
                                      if (numOfItems[index] > 1) {
                                        setState(() {
                                          numOfItems[index]--;
                                        });
                                      }
                                      order.removeAt(index);
                                      order.insert(
                                          index,
                                          Order(
                                              id: cartItems[index].id,
                                              quantity: numOfItems[index],
                                              cost: int.parse(
                                                      cartItems[index].price) *
                                                  numOfItems[index]));
                                      print(order[index].quantity);
                                    },
                                    icon: const Icon(Icons.remove),
                                    iconSize: 15,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                                Text(
                                  numOfItems[index].toString().padLeft(2, "0"),
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
                                      print("p");
                                      print(numOfItems[index]);
                                      print(index);
                                      setState(() {
                                        numOfItems[index]++;
                                        print(order[index].quantity);
                                        order.removeAt(index);
                                        order.insert(
                                            index,
                                            Order(
                                                id: cartItems[index].id,
                                                quantity: numOfItems[index],
                                                cost: int.parse(cartItems[index]
                                                        .price) *
                                                    numOfItems[index]));
                                        print("p");
                                        print(order[index].quantity);
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    iconSize: 15,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  _totalPrice.value =
                                      _totalPrice.value - order[index].cost;
                                  print(order[index].cost);
                                  order.removeAt(index);
                                  numOfItems.removeAt(index);
                                  cartItems.removeAt(index);
                                  setState(() {
                                    print(_totalPrice.value);
                                    Fluttertoast.showToast(msg: "Item removed");
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade800,
                                )),
                          ])));
            }),
        bottomNavigationBar: Row(
          children: [
            SizedBox(
              width: 200,
              child: ValueListenableBuilder<int>(
                  valueListenable: _totalPrice,
                  builder: (context, val, child) {
                    return ReusableWidget(
                        value: r'Rs.' + (val?.toStringAsFixed(2) ?? '0'));
                  }),
            ),
            Expanded(
              child: ValueListenableBuilder<int>(
                  valueListenable: _totalPrice,
                  builder: (context, val, child) {
                    return InkWell(
                      onTap: () async {
                        final dateToday = DateTime.now();
                        String date = dateToday.toString().substring(0, 16);
                        final crrUser = FirebaseAuth.instance.currentUser;
                        // final id = "P2qDVGzTnHcBnmEpgaa8sR0OPWd2";
                        if (order.isNotEmpty) {
                          final docRef = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(crrUser.uid)
                              .collection("orders")
                              .add({"cost": val, "date": date});
                          print("xx");
                          print(docRef.id);
                          print(order.length);
                          for (int i = 0; i < order.length; i++) {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(crrUser.uid)
                                .collection("orders")
                                .doc(docRef.id)
                                .collection("products")
                                .add({
                              "productid": order[i].id,
                              "quantity": order[i].quantity
                            });
                          }
                          setState(() {
                            Fluttertoast.showToast(msg: "Order Placed");
                            order.length = 0;
                            cartItems.length = 0;
                          });
                        } else {
                          Fluttertoast.showToast(msg: "Emply Order");
                        }
                      },
                      child: Container(
                        color: Colors.yellow.shade600,
                        alignment: Alignment.center,
                        height: 50.0,
                        child: const Text(
                          'Pay',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}

class ReusableWidget extends StatelessWidget {
  final String value;
  const ReusableWidget({Key key, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
