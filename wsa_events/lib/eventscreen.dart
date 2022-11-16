import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Event {
  final String description;
  final List<String> participants;
  final String place;

  Event({
    required this.description,
    required this.participants,
    required this.place
  });

  factory Event.fromJson(Map<String, dynamic> json) => new Event(
    description: json['description'],
    participants: json['participants'],
    place: json['place'],
  );

  Map<String, dynamic> toJson() => {
    'description': this.description,
    'participants': this.participants, 
    'place': this.place
  };
}

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  Future<String> getEventsJson() async => await rootBundle.loadString('events.json');
  
  @override
  Widget build(BuildContext context) {
    var event = Event.fromJson(jsonDecode(getEventsJson()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos')
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            FutureBuilder<Event>(
            
            ), 
            ListTile(
              title: const Text('OOOO'),
              subtitle: const Text('aaaaaa'),
              leading: const Icon(Icons.help_center_outlined, color: Colors.black)
            )
          ]
        )
      )
    );
  }
}