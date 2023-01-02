import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _locationName = 'Indefinido';

  @override
  void initState() {
    super.initState();
    this._setupLocalization();
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
    
    // If the permission was accepted, it will get the user's location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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
              Text(
                'Localização: ' + this._locationName,
                style: TextStyle(fontSize: 15)
              )
            ]
          )
        )
      )
    );
  }
}