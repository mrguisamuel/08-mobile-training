import 'package:flutter/material.dart';

class WSEvents {
  final List<String> allEvents = [
    'Event1',
    'Event2',
    'Event3'
  ];
}

class EventListView extends StatelessWidget {
  final wsEvents = WSEvents();

  EventListView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wsEvents.allEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(wsEvents.allEvents[index]),
          subtitle: const Text('SubTitle'),
          leading: const Icon(Icons.help_center_outlined),
          onTap: null
        );
      }
    );
  }
}

class SelectEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventListView()
    );
  }
}