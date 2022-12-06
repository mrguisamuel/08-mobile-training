import 'package:flutter/material.dart';
import 'models.dart';
import 'services.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<Tab> _allTabs = [];
  EventService _service = EventService();
  List<Event> _allEvents = [];

  Future<void> _getEvents() async {
    this._allEvents = await this._service.getEvents();
    for(int i = 0; i < this._allEvents.length; i++) this._allTabs.add(Tab(child: Text('eae')));
    setState(() { });
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
          children: <Widget>[
            SafeArea(
              child: Text('opa')
            ),
          ]
        )
      )
    );
    return Text('oi');
  }
}