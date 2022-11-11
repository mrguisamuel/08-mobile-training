import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final Image baseImage;

  const Editor({Key? key, required this.baseImage}) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editor')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: this.baseImage
              )
            ]
          )
        )
      )
    );
  }
}