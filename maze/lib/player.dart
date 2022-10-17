import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double size;
  
  Player({
    Key? key,
    this.size = 70
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle
      )
    );
  }
}