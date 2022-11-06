import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/screens/components/home/item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Product> products = [];
  List pids = [];
  @override
  Widget build(BuildContext context) {
    final crrUser = FirebaseAuth.instance.currentUser;
    // final i = "P2qDVGzTnHcBnmEpgaa8sR0OPWd2";
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Faviourits",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.4,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(crrUser.uid)
                      .collection("faviourits")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      pids.length = 0;
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        pids.add(snapshot.data.docs[i].id);
                      }
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("products")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                          if (snapshots.hasData) {
                            products.length = 0;
                            for (int i = 0;
                                i < snapshots.data.docs.length;
                                i++) {
                              for (int j = 0; j < pids.length; j++) {
                                if (snapshots.data.docs[i].id == pids[j]) {
                                  products.add(Product(
                                      id: snapshots.data.docs[i].id,
                                      image: snapshots.data.docs[i]['img'],
                                      title: snapshots.data.docs[i]['title'],
                                      price: snapshots.data.docs[i]['price'],
                                      description: snapshots.data.docs[i]
                                          ['description'],
                                      type: snapshots.data.docs[i]['type']));
                                }
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
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
