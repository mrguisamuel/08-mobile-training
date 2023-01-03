import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _locationName = 'Indefinido';
  DateTime _currentTime = new DateTime.now();
  FlutterSoundRecorder _recorder = new FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    this._setupLocalization();
  }

  Future<void> _setupRecorder() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
  }

  Future<void> _setupLocalization() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
      return;
    
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied)
        return;
    }

    if(permission == LocationPermission.deniedForever)
      return;
    
    // If the permission was accepted, it will get the user's position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await placemarkFromCoordinates(
      position.latitude, position.longitude
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        this._locationName = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da foto')
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Digite um título para a foto',
                  style: TextStyle(fontSize: 20)
                ),
              ),
              Container(
                width: size.width * 0.8,
                child: TextFormField(
                  decoration: InputDecoration(
                    helperText: ''
                  )
                )
              ),
              this._locationName != 'Indefinido' ? Text(
                'Localização: ' + this._locationName,
                style: TextStyle(fontSize: 15)
              ) : CircularProgressIndicator(),
              Padding(
                child: Text(
                  'Data: ' +
                  '${this._currentTime.day}/${this._currentTime.month}/${this._currentTime.year} - '+ 
                  '${this._currentTime.hour}:${this._currentTime.minute}',
                  style: TextStyle(fontSize: 15)
                ),
                padding: const EdgeInsets.all(20)
              ),

            ]
          )
        )
      )
    );
  }
}