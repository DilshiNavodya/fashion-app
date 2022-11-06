import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);
  Future<LoginScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final crrUser = FirebaseAuth.instance.currentUser;
    // final id = "P2qDVGzTnHcBnmEpgaa8sR0OPWd2";
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: crrUser.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.redAccent, Colors.pinkAccent])),
                    child: SizedBox(
                      width: double.infinity,
                      height: 300.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                              ),
                              radius: 50.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data.docs[0]['username'],
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data.docs[0]['email'],
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 12, 12, 12),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              snapshot.data.docs[0]['contact'],
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 12, 12, 12),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                                width: 200.00,
                                child: RaisedButton(
                                  onPressed: () {
                                    _signOut();
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  elevation: 0.0,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                              Color.fromARGB(255, 71, 62, 244),
                                              Color.fromARGB(255, 66, 5, 131)
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 300.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Log Out",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      )),
                                ))
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Orders",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(crrUser.uid)
                          .collection("orders")
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    color: Colors.white,
                                    elevation: 5.0,
                                    child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                  width: 130,
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                      "${snapshot.data.docs[index]['date']}",
                                                      style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.grey),
                                                    ),
                                                  )),
                                              SizedBox(
                                                  width: 130,
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                      "Rs.${snapshot.data.docs[index]['cost']}.00",
                                                      style: const TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.grey),
                                                    ),
                                                  )),
                                            ])));
                              });
                        } else {
                          return Container();
                        }
                      }),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
