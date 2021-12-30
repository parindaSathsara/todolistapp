import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todolistapp/models/dbhelper.dart';
import 'package:todolistapp/views/homepage.dart';
import 'package:todolistapp/views/taskslist.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 int number=0;

  DBHelper db=new DBHelper();

  void countUser() async {
    int count = await db.getUserCount();
    number=count;

    if(number>=1){
      Timer(
        Duration(seconds: 4),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TasksList(),
          ),
        ),
      );
    }
    else{
      Timer(
        Duration(seconds: 4),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    countUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 250.0,
                  width: 250.0,
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFFFF0083)),
            ),
          ],
        ),
      ),
    );
  }
}
