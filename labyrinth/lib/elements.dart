import 'package:flutter/material.dart';

class Entity extends StatelessWidget {
  final double x;
  final double y;
  final MaterialColor color;
  final double radius;

  const Entity({
    Key? key,
    required this.x,
    required this.y,
    required this.color,
    required this.radius
  }) : super(key: key);

  bool isColliding(int posA, int posB) {
    if(posA > posB) return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: this.x,
      top: this.y,
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(this.radius) 
        )
      )
    );
  }
}

class Wall extends StatelessWidget {
  final MaterialColor color;
  final double width;
  final double height;
  final double x;
  final double y;

  const Wall({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.x,
    required this.y
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned( 
      right: this.x,
      top: this.y,
      child: Container(
        decoration: BoxDecoration(color: this.color),
        width: this.width,
        height: this.height
      )
    );
  }
}