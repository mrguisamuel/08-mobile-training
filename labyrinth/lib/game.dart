import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'package:sensors_plus/sensors_plus.dart';
import 'elements.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  double distanceX = 0;
  double distanceY = 0;
  final double playerSize = 40;
  final int playerSpeed = 40;
  final double holeSize = 30;

  @override
  void initState() {
    super.initState();

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        distanceX -= (event.x * this.playerSpeed);
        distanceY -= (event.y * this.playerSpeed);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /*
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
            */
            // Player Entity
            Entity(
              x: 0,
              y: 0,
              color: Colors.orange,
              radius: 40
            ),

            // Building Level 1
            Wall(
              x: 250 - size.width, 
              y: size.height * 0.15, 
              width: size.width * .9, 
              height: 40, 
              color: Colors.brown
            ),
            Entity(
              x: size.width - 200,
              y: size.height * 0.1,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: size.width - 45,
              y: size.height * 0.05,
              radius: this.holeSize,
              color: Colors.red
            ),
            Wall(
              x: 100, 
              y: size.height * 0.45, 
              width: size.width * .9, 
              height: 40, 
              color: Colors.brown
            ),
            Entity(
              x: size.width - 45,
              y: size.height * 0.35,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: size.width - 150,
              y: size.height * 0.30,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: 10,
              y: size.height * 0.30,
              radius: this.holeSize,
              color: Colors.red
            ),
            Wall(
              x: 150 - size.width, 
              y: size.height * 0.70, 
              width: size.width * .9, 
              height: 40, 
              color: Colors.brown
            ),
            Entity(
              x: 10,
              y: size.height * 0.6,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: size.width - 40,
              y: size.height * 0.55,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: size.width - 40,
              y: size.height * 0.85,
              radius: this.holeSize,
              color: Colors.red
            ),
            Entity(
              x: 20,
              y: size.height * 0.85,
              radius: this.holeSize + 10,
              color: Colors.yellow
            ),
          ]
        )
      )
    );
  }
}