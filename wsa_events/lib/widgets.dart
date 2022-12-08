import 'package:flutter/material.dart';
import 'models.dart';
import 'baseeventscreen.dart';

class ListEventsView extends StatelessWidget {
  final List<Event> listEvents;
  final String whichDate;

  const ListEventsView({
    Key? key,
    required this.listEvents,
    required this.whichDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: this.listEvents.length,
        itemBuilder: (context, index) {
          if(this.whichDate == this.listEvents[index].date) {
            return ListTile(
              title: Text(this.listEvents[index].title),
              subtitle: Text('Horário: ' + this.listEvents[index].hour),
              leading: const Icon(Icons.addchart_rounded, color: Colors.black),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BaseEventScreen(event: this.listEvents[index])
                  )
                );
              }
            );
          } else return Container(height: 0, width: 0);
        }
      )
    );
  }
}