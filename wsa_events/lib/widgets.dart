import 'package:flutter/material.dart';
import 'models.dart';
import 'utility.dart';

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
          List<String> dt = pickHourAndDate(this.listEvents[index].dateHour);
          if(this.whichDate == dt[1]) {
            return ListTile(
              title: Text(this.listEvents[index].title),
              subtitle: Text('Horário: ' + dt[0]),
              leading: const Icon(Icons.addchart_rounded, color: Colors.black)
            );
          } else return Container(height: 0, width: 0);
        }
      )
    );
  }
}