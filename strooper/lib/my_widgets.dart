import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String message;
  final double width;
  VoidCallback? action;

  Button({
    Key? key,
    required this.message,
    required this.width,
    this.action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: this.width,
      child: OutlinedButton(
        onPressed: this.action,
        child: Text(this.message)
      )
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double value;
  final double totalValue;

  CustomProgressBar({
    required this.width, 
    required this.value, 
    required this.totalValue
  });

  @override
  Widget build(BuildContext context) {
    double ratio = this.value / this.totalValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.timer),
        SizedBox(width: 5),
        Stack(
          children: <Widget>[
            Container(
              width: this.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)
              )
            ),
            Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 3,
              child: AnimatedContainer(
                height: 10,
                width: this.width * ratio,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (ratio < 0.3) ? Colors.red : (ratio < 0.6) ? Colors.amber[400] : Colors.lightGreen,
                  borderRadius: BorderRadius.circular(5)
                )
              )
            )
          ]
        )
      ]
    );
  }
}