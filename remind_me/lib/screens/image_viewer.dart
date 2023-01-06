import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImageViewer extends StatefulWidget {
  // Necessary attributes to generalize this class
  final Uint8List image;
  final Uint8List audio;
  final String date;
  final String time;
  final String location;
  final String title;

  const ImageViewer({
    Key? key,
    required this.image,
    required this.audio,
    required this.date,
    required this.time,
    required this.location,
    required this.title
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: size.width * 0.7,
                height: size.height * 0.7,
                child: Image.memory(widget.image)
              ),
              Text(
                widget.title,
                style: TextStyle(fontSize: 20)
              ),
              Text('Data: ' + widget.date + ', às ' + widget.time),
              Text('Local: ' + widget.location),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    'Voltar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}