import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'editor.dart' show Editor;
import 'package:image/image.dart' as ui;
import 'dart:async';
import 'dart:io';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Home({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _lastImage;
  //File _watermarkImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _startCamera(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startCamera(int whichCamera) {
    _controller = CameraController(
      widget.cameras[whichCamera],
      ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Remind-me'),
          bottom: TabBar(
            tabs: <Tab>[
              Tab(
                icon: const Icon(Icons.add_a_photo_rounded),
                child: const Text('Tirar foto', textAlign: TextAlign.center)
              ),
              Tab(
                icon: const Icon(Icons.app_shortcut_rounded),
                child: const Text('Editar foto', textAlign: TextAlign.center)
              ),
            ]
          )
        ),
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.5,
                      width: size.width * 0.8,
                      child: FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done) {
                            return CameraPreview(_controller);
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          child: Text(
                            'Frente',
                            textAlign: TextAlign.center
                          ),
                          onPressed: () => setState(() => _startCamera(0))
                       ),
                        SizedBox(width: 30),
                        FloatingActionButton(
                          child: Text(
                            'Trás',
                            textAlign: TextAlign.center
                          ),
                          onPressed: () => setState(() => _startCamera(1))
                        )
                      ]
                    ),
                    Spacer(),
                    ElevatedButton(
                      child: Text('Tirar foto'),
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller.takePicture();
                          setState(() => this._lastImage = File(image.path));
                        } catch(e) {
                          print(e);
                        }
                      }
                    )
                  ]
                )
              ),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                      child: this._lastImage == null ? Text('tire a foto!') : Image.file(this._lastImage!),
                    ),
                    /*
                    ElevatedButton(
                      child: Text('Usar essa foto mesmo'),
                      onPressed: () async {
                        ui.Image originalImage = ui.decodeImage(this._lastImage.readAsBytesSync());
                        ui.Image watermarkImage = ui.decodeImage(this._watermarkImage.readAsBytesSync());

                        ui.Image image = ui.Image(160, 50);
                        ui.drawImage(image, watermarkImage);

                        if(this._lastImage != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editor(baseImage: Image.file(this._lastImage!))
                            )
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Insira uma imagem antes de continuar!'))
                          );
                        }
                      }
                    ),
                    */
                    ElevatedButton(
                      child: Text('Abrir Galeria'),
                      onPressed: () async {
                        final PickedFile? myFile = await _picker.getImage(source: ImageSource.gallery);
                        setState(() => this._lastImage = File(myFile!.path));
                      }
                    )
                  ]
                )
              ),
            ]
          )
        )
      ),
    );
  }
}