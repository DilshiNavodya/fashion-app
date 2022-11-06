import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.red,
  //     ),
  //     home: SplashScreen(),
  //   );
  // }
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext, Child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter app',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
