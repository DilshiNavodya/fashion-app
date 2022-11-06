import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/screens/bottom_nav_controller.dart';
import 'package:fashion_app/screens/bottom_nav_pages/cart.dart';
import 'package:fashion_app/screens/components/details/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/models/product.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background_color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => BottomNavController(index: 2))),
        ),
        const SizedBox(width: 20.0 / 2)
      ],
    );
  }
}
