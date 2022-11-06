import 'package:flutter/material.dart';
import 'package:fashion_app/models/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 300,
            child: Image.network(
              product.image,
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
