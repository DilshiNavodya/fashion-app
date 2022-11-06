import 'package:flutter/material.dart';

import '../components/home/body_page.dart';
import '../components/home/header_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderPage(),
            const SizedBox(
              height: 20,
            ),
            BodyPage(),
          ],
        ),
      ),
    );
  }
}
