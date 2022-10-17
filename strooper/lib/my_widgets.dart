import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String message;
  final double width;

  Button({
    Key? key,
    required this.message,
    required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: this.width,
      child: OutlinedButton(
        onPressed: null,
        child: Text(this.message)
      )
    );
  }
}