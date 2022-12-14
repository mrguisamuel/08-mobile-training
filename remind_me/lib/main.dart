import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/pickedphoto.dart';
import 'screens/editor.dart';
import 'screens/details.dart';
import 'screens/gallery.dart';
import 'screens/image_viewer.dart';
/*
import 'screens/home.dart';
import 'package:camera/camera.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();

  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(cameras: cameras),
      }
    )
  );
}
*/

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/welcome',
      routes: {
        '/welcome': (BuildContext context) => const Welcome(),
        '/pickedphoto': (BuildContext context) => const PickedPhoto(),
        '/editor': (BuildContext context) => const Editor(),
        '/details': (BuildContext context) => const Details(),
        //'/image_viewer': (BuildContext context) => const ImageViewer(),
        '/gallery': (BuildContext context) => const Gallery(),
      }
    )
  );
}