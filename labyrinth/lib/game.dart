import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'package:sensors_plus/sensors_plus.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Vector3 _playerPos = Vector3.zero();
  double distanceX = 0;
  double distanceY = 0;
  final int playerSpeed = 40;

  @override
  void initState() {
    super.initState();

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        distanceX -= this._playerPos.x;
        distanceY -= this._playerPos.y;

        this._playerPos.setValues(event.x * playerSpeed, event.y * playerSpeed, event.z);
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
              top: this.distanceY,
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