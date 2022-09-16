import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  double x = 0, y = 0, z = 0;
  String direction = 'none';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Text(direction)
      )
    );
  }

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);
      
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        if(x > 0)
          direction = 'back';
        else if(x < 0)
          direction = 'forward';
        else if(y > 0)
          direction = 'left';
        else if(y < 0)
          direction = 'right';
      }); 
    });
  }
}