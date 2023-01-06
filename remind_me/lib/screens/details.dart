import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/database.dart';
import '../models/wsa_image.dart';
import '../utils/globals.dart';
import 'dart:io';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _locationName = 'Indefinido';
  DateTime _currentTime = new DateTime.now();
  FlutterSoundRecorder _recorder = new FlutterSoundRecorder();
  TextEditingController _titleController = new TextEditingController();
  File? _audio;

  String _date = 'XX/YY/ZZZZ';
  String _time = 'XX:YY';

  _DetailsState() {
    // Save date and time as string
    _date = '${_currentTime.day.toString()}/${_currentTime.month.toString()}/${_currentTime.year.toString()}';
    _time = '${_currentTime.hour.toString()}:${_currentTime.minute.toString()}';
  }

  @override
  void initState() {
    super.initState();
    this._setupLocalization();
    this._setupRecorder();
  }

  @override
  void dispose() {
    this._recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _setupRecorder() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted)
      throw 'Microphone permission not granted';
    await this._recorder.openRecorder();
    this._recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500)
    );
  }

  Future<void> _record() async {
    await this._recorder.startRecorder(toFile: 'audio');
  }

  Future<void> _stopRecorder() async {
    final path = await this._recorder.stopRecorder();
    this._audio = File(path!);
    print('Recorded audio: $_audio');
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
                  controller: this._titleController,
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
                  'Data: ${this._date}, às ${this._time}',
                  style: TextStyle(fontSize: 15)
                ),
                padding: const EdgeInsets.all(10)
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Icon(
                    this._recorder.isRecording ? Icons.stop : Icons.mic,
                    size: 80
                  ),
                  onPressed: () async {
                    if(this._recorder.isRecording)
                      await this._stopRecorder();
                    else
                      await this._record();
                    setState(() { });
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () async {
                    await MyDatabase.insertImage(
                      WSAImage(
                        title: this._titleController.text,
                        location: this._locationName,
                        time: this._time,
                        date: this._date,
                        image: Globals.watermarkedImage!,
                        audio: await this._audio!.readAsBytes()
                      )
                    );
                    Navigator.of(context).pushReplacementNamed('/gallery');
                    Fluttertoast.showToast(
                      msg: 'Enviado com sucesso!',
                      fontSize: 16.0
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      'Enviar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      )
                    )
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