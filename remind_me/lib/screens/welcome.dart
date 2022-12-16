import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/globals.dart';
import 'dart:io';
import 'pickedphoto.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image == null) return;
    Globals.pickedImage = File(image.path);
    Navigator.of(context).pushReplacementNamed('/pickedphoto');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text('Olá, seja bem-vindo ao aplicativo Relembre-me'),
              TextButton(
                onPressed: () => this._getImage(),
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Tirar Foto',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center
                  )
                )
              ),
              TextButton(
                onPressed: null,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Abrir Galeria',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center
                  )
                )
              ),
            ]
          )
        )
      )
    );
  }
}