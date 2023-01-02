import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/globals.dart';
import 'welcome.dart';

class PickedPhoto extends StatefulWidget {
  const PickedPhoto({Key? key}) : super(key: key);

  @override
  State<PickedPhoto> createState() => _PickedPhotoState();
}

class _PickedPhotoState extends State<PickedPhoto> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(
              Globals.pickedImage!,
              height: size.height * .5,
              width: size.width * .8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/editor'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  child: Text('Continuar', textAlign: TextAlign.center),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/welcome'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  child: Text('Voltar', textAlign: TextAlign.center),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}