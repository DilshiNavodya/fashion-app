import 'package:flutter/material.dart';
import 'package:fashion_app/models/product.dart';

import 'add_to_cart.dart';
import 'product_title_and_price.dart';
import 'fav_btn.dart';
import 'description.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: 20.0,
                    right: 20.0,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ProductTitlePrice(product: product),
                      // const SizedBox(height: 20.0 / 2),
                      Description(product: product),
                      // const SizedBox(height: 10.0 / 2),
                      FavBtn(product: product),
                      // const SizedBox(height: 10.0 / 2),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
