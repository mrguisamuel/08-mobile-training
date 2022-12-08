import 'package:flutter/material.dart';
import 'models.dart';
import 'services.dart';
import 'widgets.dart';
import 'utility.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventService _service = EventService();
  
  // They will be generated according to number of events
  List<Tab> _allTabs = [];
  List<Event> _allEvents = [];
  List<String> _dates = [];
  List<ListEventsView> _screens = [];

  Future<void> _getEvents() async {
    this._allEvents = await this._service.getEvents();
    var formattedDates = [];

    this._allEvents.forEach((event) {
      final d = event.dateHour.split('T');
      formattedDates.add(formatDate(d[0]));
    });

    // Remove repeated dates
    this._dates = new List<String>.from(formattedDates.toSet().toList());
    
    setState(() {
      for(int i = 0; i < this._dates.length; i++) {
        this._allTabs.add(Tab(child: Text(this._dates[i])));
        this._screens.add(ListEventsView(listEvents: this._allEvents, whichDate: this._dates[i]));
      }
    });
  }

  @override
  void initState() {
    this._getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this._allTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eventos'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              tabs: this._allTabs,
              isScrollable: true
            )
          )
        ),
        body: TabBarView(
          children: this._allTabs.length <= 0 ? 
          [CircularProgressIndicator()]
          : this._screens.toList()
        )
      )
    );
    return Text('oi');
  }
}