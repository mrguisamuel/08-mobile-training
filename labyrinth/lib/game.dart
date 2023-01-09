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
  double distanceX = 0;
  double distanceY = 0;
  final int playerSpeed = 20;

  @override
  void initState() {
    super.initState();

    // Listen Gyroscope
    motionSensors.userAccelerometer.listen((UserAccelerometerEvent event) {
      setState(() {
        this._playerPos.setValues(event.x * playerSpeed, event.y, event.z * playerSpeed);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(distanceX.toString()),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              right: this.distanceX, 
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