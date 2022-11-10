import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

class Home extends StatefulWidget {
  final CameraDescription camera;

  const Home({Key? key, required this.camera}) : super(key: key);

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
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
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
                child: const Text('Editar foto')
              )
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
                          onPressed: null
                       ),
                        SizedBox(width: 30),
                        FloatingActionButton(
                          child: Text(
                            'Trás',
                            textAlign: TextAlign.center
                          ),
                          onPressed: null
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
                child: this.lastImage == null ? Text('tire a foto!') : this.lastImage
              )
            ]
          )
        )
      ),
    );
  }
}