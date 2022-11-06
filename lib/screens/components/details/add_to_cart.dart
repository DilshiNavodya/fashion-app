import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/models/cartItem.dart';
import 'package:fashion_app/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    var state = true;
    print("s");
    print(widget.product.id);
    print("s");
    if (cartItems.isNotEmpty) {
      for (int i = 0; i < cartItems.length; i++) {
        print(cartItems[i].id);
        if (cartItems[i].id == widget.product.id) {
          state = false;
        }
        print(state);
      }
    } else {
      state = true;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: AppColors.background_color,
                onPressed: () {
                  print("s");
                  print(state);
                  print("s");
                  if (state) {
                    cartItems.add(CartItem(
                        id: widget.product.id,
                        image: widget.product.image,
                        title: widget.product.title,
                        price: widget.product.price));
                    order.add(Order(
                        id: widget.product.id,
                        quantity: 1,
                        cost: int.parse(widget.product.price)));
                    state = false;
                    setState(() {
                      Fluttertoast.showToast(msg: "Item added to the cart");
                    });
                  } else {
                    setState(() {
                      Fluttertoast.showToast(msg: "Already added to the cart");
                    });
                  }
                  print(cartItems.length);
                },
                child: Text(
                  "add to cart".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
