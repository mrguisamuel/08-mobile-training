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

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<dynamic> _items = [];
  static const int numberDays = 3;

  @override
  void initState() {
    super.initState();
    this.getEventsJson();
  }

  Future<void> getEventsJson() async {
    final String response = await rootBundle.loadString('assets/json/events.json');
    setState(() => this._items = jsonDecode(response));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: numberDays,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eventos'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('eae')
              ),
              Tab(
                child: Text('eae')
              ),
              Tab(
                child: Text('eae')
              ),
            ]
          )
        ),
        body: TabBarView(
          children: <Widget>[
            SafeArea(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['description']),
                    subtitle: Text(_items[index]['place'])
                  );
                }
              ),
            )
          ]
        )
      )
    );
  }
}