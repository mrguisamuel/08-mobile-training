import 'package:flutter/material.dart';
import 'search.dart';
import 'models.dart';
import 'services.dart';
import 'widgets.dart';
import 'utility.dart';
import 'globals.dart';

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
    if(Globals.searchType == SearchType.title && Globals.searchCharacters.length > 0) {
      this._searchEvent(Globals.searchCharacters);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: this._allTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text('Eventos')
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              tabs: this._allTabs,
              isScrollable: true
            )
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SearchScreen()
                )
              )
            )
          ]
        ),
        body: TabBarView(
          children: this._allTabs.length <= 0 ? 
          [
            Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.5),
                CircularProgressIndicator()
              ]
            )
          ]
          : this._screens.toList()
        )
      )
    );
  }

  void _searchEvent(String query) {
    final suggestions = this._allEvents.where((event) {
      final eventTitle = event.title.toLowerCase();
      final input = query.toLowerCase();

      return eventTitle.contains(input);
    }).toList();

    setState(() => this._allEvents = suggestions);
  }
}