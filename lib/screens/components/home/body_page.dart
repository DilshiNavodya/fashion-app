import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/screens/components/details/details_screen.dart';
import 'package:fashion_app/screens/components/home/categories.dart';
import 'package:fashion_app/screens/components/home/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyPage extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Categories",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Categories(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
