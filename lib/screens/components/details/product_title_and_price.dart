import 'package:fashion_app/const/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/models/product.dart';

class ProductTitlePrice extends StatelessWidget {
  const ProductTitlePrice({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              text: "Rs.${product.price}",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
