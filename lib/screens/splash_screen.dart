import 'dart:async';

import 'package:fashion_app/screens/bottom_nav_controller.dart';
import 'package:fashion_app/screens/bottom_nav_pages/home.dart';
import 'package:fashion_app/screens/components/details/body.dart';
import 'package:fashion_app/screens/components/home/body_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/const/AppColors.dart';
import 'package:fashion_app/screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, CupertinoPageRoute(builder: (_) => LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_color,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Fashion App",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 44.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
