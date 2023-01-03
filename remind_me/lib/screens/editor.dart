import 'package:flutter/material.dart';
import '../utils/globals.dart';
import 'package:image/image.dart' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);  

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  void initState() {
    super.initState();
    this._addImageWatermark();
  }

  Future<void> _addImageWatermark() async {
    final w = await rootBundle.load('assets/images/world-skills-logo.png');
    final wt = w.buffer.asUint8List();

    final originalImage = ui.decodeImage(await Globals.pickedImage!.readAsBytes());
    final watermark = ui.decodeImage(wt);

    final image = ui.Image(watermark!.width, watermark!.height);
    ui.drawImage(image, watermark!);

    int x = (originalImage!.width / 2).round();
    int y = (originalImage!.height / 2).round();

    ui.copyInto(
      originalImage!,
      image,
      dstX: x,
      dstY: y,
    );

    final wmImage = ui.encodePng(originalImage);
    final result = Uint8List.fromList(wmImage);

    setState(() => Globals.watermarkedImage = result);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Editor')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: size.width * 0.9,
                height: size.height * 0.7,
                child: Globals.watermarkedImage == null ? 
                CircularProgressIndicator() : Image.memory(Globals.watermarkedImage!)
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/details'),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width,
                  child: Text(
                    'Continuar', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
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