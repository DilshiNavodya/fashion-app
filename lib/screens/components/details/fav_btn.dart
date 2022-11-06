import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_counter.dart';

class FavBtn extends StatefulWidget {
  final Product product;

  const FavBtn({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  _FavBtnState createState() => _FavBtnState();
}

class _FavBtnState extends State<FavBtn> {
  Product product;
  bool crr = false;
  bool state;
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final crrUser = FirebaseAuth.instance.currentUser;
    // final uid = "P2qDVGzTnHcBnmEpgaa8sR0OPWd2";
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(crrUser.uid)
            .collection("faviourits")
            .where("productid", isEqualTo: product.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              state = false;
            } else {
              state = true;
            }
            print("state");
            print(state);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FavoriteButton(
                  isFavorite: state,
                  valueChanged: (_isFavorite) {
                    if (_isFavorite) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(crrUser.uid)
                          .collection("faviourits")
                          .doc(product.id)
                          .set({"productid": product.id});
                    } else {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(crrUser.uid)
                          .collection("faviourits")
                          .doc(product.id)
                          .delete()
                          .then((value) => null);
                    }
                  },
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
