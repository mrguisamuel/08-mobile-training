import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoarding()
        )
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }
}

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("GeeksForGeeks")),
      body: Center(
        child:Text("Home page",textScaleFactor: 2,)
      ),
    );
  }
}