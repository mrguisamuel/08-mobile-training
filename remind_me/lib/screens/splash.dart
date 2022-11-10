import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash (Key? key) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(context,
      )
    )
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.camera, size: 80)
      )
    );
  }
}