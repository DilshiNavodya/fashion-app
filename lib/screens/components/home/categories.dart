import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/screens/components/home/item_card.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Product> products = [];
  List<String> categories = ["WOMENS", "MENS", "KIDS"];
  int selectedIndex = 0;
  String type = "women";

  @override
  Widget build(BuildContext context) {
    print(products);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SizedBox(
            height: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => buildCategory(index),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.38,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var count = 0;
                  products.length = 0;
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    if (snapshot.data.docs[i]['type'] == type) {
                      print(snapshot.data.docs[i].id);
                      products.add(Product(
                          id: snapshot.data.docs[i].id,
                          image: snapshot.data.docs[i]['img'],
                          title: snapshot.data.docs[i]['title'],
                          price: snapshot.data.docs[i]['price'],
                          description: snapshot.data.docs[i]['description'],
                          type: snapshot.data.docs[i]['type']));
                      count++;
                    }
                  }

                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (context, index) => ItemCard(
                            product: products[index],
                          ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        )
      ],
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (index == 0) {
          type = "women";
        } else if (index == 1) {
          type = "men";
        } else {
          type = "kid";
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 18,
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index
                      ? AppColors.background_color
                      : AppColors.textLightColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0 / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
