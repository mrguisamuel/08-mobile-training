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