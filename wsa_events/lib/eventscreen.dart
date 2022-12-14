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
  String? _selectedItem = Globals.allTypes[0];
  SearchType _searchType = SearchType.title;
  bool isSearching = false;
  TextEditingController _searchFieldController = TextEditingController();
  var _focusNode = FocusNode();

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

  Widget returnSearchType(double _width) {
    switch(this._searchType){
      case SearchType.participants:
        return SizedBox( 
          width: _width,
          height: 50,
          child: DropdownButton<String>(
            isExpanded: true,
            items: Globals.allTypes.map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item.splitAndCapitalize('_').join(' ')) 
            )).toList(),
            onChanged: (item) => setState(() => this._selectedItem = item),
            value: this._selectedItem
          )
        );
        break;
      default:
        return Container(
          width: _width,
          height: 50,
          child: Center(
            child: TextField(
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 25.0, color: Colors.white),
              focusNode: this._focusNode,
              onSubmitted: (value) {
                this._searchEvent(this._searchFieldController.text);
                //this.isSearching = false;
              }
            )
          )
        );
        break;
    }
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
            child: this.isSearching ? this.returnSearchType(size.width) : Text('Eventos')
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
              icon: Icon(this.isSearching ? Icons.cancel : Icons.search_rounded),
              onPressed: () {
                if(this.isSearching) {
                  setState(() => isSearching = false);
                }
                else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            this._focusNode.requestFocus();
                            setState(() => this.isSearching = true);
                            /*
                            showSearch(
                              context: context,
                              delegate: MySearchDelegate(
                                searchType: this._searchType
                              )
                            );
                            */
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: const Text('Pesquisar')
                          )
                        )
                      ],
                      title: const Text('Pesquisar por:'),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RadioListTile<SearchType>(
                                title: Text('Título'),
                                value: SearchType.title,
                                groupValue: this._searchType,
                                onChanged: (SearchType? value) {
                                  setState(() => this._searchType = value!);
                                }
                              ),
                              RadioListTile<SearchType>(
                                title: Text('Descrição'),
                                value: SearchType.description,
                                groupValue: this._searchType,
                                onChanged: (SearchType? value) {
                                  setState(() => this._searchType = value!);
                                }
                              ),
                              RadioListTile<SearchType>(
                                title: Text('Participantes'),
                                value: SearchType.participants,
                                groupValue: this._searchType,
                                onChanged: (SearchType? value) {
                                  setState(() => this._searchType = value!);
                                }
                              ),
                            ]
                          );
                        }
                      )
                    )
                  );
                }
              }

              /*
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SearchScreen()
                )
              )
              */
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

class MySearchDelegate extends SearchDelegate {
  String? _selectedItem = Globals.allTypes[0];
  final SearchType searchType;

  MySearchDelegate({
    required this.searchType,
  });

  @override
  String get searchFieldLabel {
    if(this.searchType == SearchType.description)
      return 'Descrição';
    else return 'Título'; 
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_rounded),
    onPressed: () => close(context, null)
  );

  @override
  List<Widget>? buildActions(BuildContext context) => <Widget>[
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if(this.query.isEmpty) close(context, null);
        else this.query = '';
      },
    )
  ];

  @override
  Widget buildResults(BuildContext context) => Container(
    child: this.searchType == SearchType.participants ? 
    DropdownButton<String>(
      isExpanded: true,
      items: Globals.allTypes.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item.splitAndCapitalize('_').join(' ')) 
      )).toList(),
      onChanged: (item) => this._selectedItem = item,
      value: this._selectedItem
    ) : Text('eae')
  );

  @override
  Widget buildSuggestions(BuildContext context) => TextField();
}