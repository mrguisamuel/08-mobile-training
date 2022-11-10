import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(camera: firstCamera)
      }
    )
  );
}