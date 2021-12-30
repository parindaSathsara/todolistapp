import 'package:flutter/material.dart';
import 'package:todolistapp/views/splash.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.redAccent,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0XFFFF0083),
            ),
        pageTransitionsTheme: PageTransitionsTheme(builders: const {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: SplashScreen(),
    );
  }
}
