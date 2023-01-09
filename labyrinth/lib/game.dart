import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Vector3 _playerPos = Vector3.zero();
  double distance = 0;

  @override
  void initState() {
    super.initState();

    // Listen Gyroscope
    motionSensors.gyroscope.listen((GyroscopeEvent event) {
      setState(() {
        if(event.x != 0)
          distance += this._playerPos.x;

        this._playerPos.setValues(event.x * 20, event.y, event.z);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(distance.toString()),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              right: this.distance, 
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(40)
                )
              )
            )
          ]
        )
      )
    );
  }
}