import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Vector3 _gyroscope = Vector3.zero();

  @override
  void initState() {
    super.initState();
    motionSensors.gyroscope.listen((GyroscopeEvent event) {
      setState(() => this._gyroscope.setValues(event.x, event.y, event.z));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._gyroscope.x.toString()),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
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