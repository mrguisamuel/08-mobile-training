import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Location myLocation = new Location();
  String _locationName = 'Indefinido';

  @override
  void initState() {
    super.initState();
    this._setupLocalization();
  }

  Future<void> _setupLocalization() async {
    var _serviceEnabled = await this.myLocation.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await this.myLocation.requestService();
      if(!_serviceEnabled)
        return;
    }

    var _permissionGranted = await this.myLocation.hasPermission();
    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await this.myLocation.requestPermission();
      if(_permissionGranted != PermissionStatus.granted)
        return;
    }

    // If all checks was positive, then it is going to return the location data
    LocationData myLocationData = await this.myLocation.getLocation();
    final coordinates = new Coordinates(
      myLocationData.latitude, myLocationData.longitude
    );
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
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