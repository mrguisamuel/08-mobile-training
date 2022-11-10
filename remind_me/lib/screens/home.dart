import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
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
  Image? lastImage;

  @override
  void initState() {
    super.initState();
    startCamera(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startCamera(int whichCamera) {
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Relembra-me'),
          bottom: TabBar(
            tabs: <Tab>[
              Tab(
                icon: const Icon(Icons.add_a_photo_rounded),
                child: const Text('Tirar foto')
              ),
              Tab(
                icon: const Icon(Icons.app_shortcut_rounded),
                child: const Text('Editar foto da câmera')
              ),
              Tab(
                icon: const Icon(Icons.app_shortcut_rounded),
                child: const Text('Usar foto da galeria')
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
                          onPressed: () => setState(() => startCamera(0))
                       ),
                        SizedBox(width: 30),
                        FloatingActionButton(
                          child: Text(
                            'Trás',
                            textAlign: TextAlign.center
                          ),
                          onPressed: () => setState(() => startCamera(1))
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
                          setState(() => this.lastImage = Image.file(File(image.path)));
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
                      child: this.lastImage == null ? Text('tire a foto!') : this.lastImage,
                    ),
                    ElevatedButton(
                      child: Text('Usar essa foto mesmo'),
                      onPressed: null
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }
}