import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'player.dart';
import 'dart:async';
import 'dart:ui';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int velocity = 5;

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer = _accelerometerValues.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: -velocity * _accelerometerValues[0],
            top: velocity * _accelerometerValues[1],
            child: Player()
          )
        ]
      )
    );
  }
}