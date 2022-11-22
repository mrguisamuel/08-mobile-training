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

  final List<Tab> allTabs = [
    Tab(child: Text('6 AM')),
    Tab(child: Text('7 AM')),
    Tab(child: Text('8 AM')),
    Tab(child: Text('9 AM')),
    Tab(child: Text('10 AM')),
    Tab(child: Text('11 AM')),
    Tab(child: Text('12 AM')),
    Tab(child: Text('1 PM')),
    Tab(child: Text('2 PM')),
    Tab(child: Text('3 PM')),
    Tab(child: Text('4 PM')),
    Tab(child: Text('5 PM')),
    Tab(child: Text('6 PM')),
    Tab(child: Text('7 PM')),
    Tab(child: Text('8 PM')),
    Tab(child: Text('9 PM')),
    Tab(child: Text('10 PM'))
  ];

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
      length: allTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eventos'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              tabs: this.allTabs,
              isScrollable: true
            )
          )
        ),
        body: TabBarView(
          children: <Widget>[
            SafeArea(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  if(this._items[index]['hour'] == '6 AM') {
                    return ListTile(
                      title: Text(this._items[index]['description']),
                      subtitle: Text(this._items[index]['place'])
                    );
                  } else return SizedBox.shrink();
                }
              ),
            ),
            SafeArea(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  if(this._items[index]['hour'] == '7 AM') {
                    return ListTile(
                      title: Text(this._items[index]['description']),
                      subtitle: Text(this._items[index]['place'])
                    );
                  } else return SizedBox.shrink();
                }
              ),
            ),
            SafeArea(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  if(this._items[index]['hour'] == '8 AM') {
                    return ListTile(
                      title: Text(this._items[index]['description']),
                      subtitle: Text(this._items[index]['place'])
                    );
                  } else return SizedBox.shrink();
                }
              ),
            ),
          ]
        )
      )
    );
  }
}