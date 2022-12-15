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
  List<Widget> _screens = [];

  Future<void> _getEvents() async {
    this._allEvents = await this._service.getEvents();
    this._createAllScreens();
  }

  void _removeAllScreens() {
    // Reset all lists
    this._allTabs.clear();
    this._allEvents.clear();
    this._dates.clear();
    this._screens.clear();
  }

  void _resetAllScreens() {
    this._removeAllScreens();
    this._getEvents();
  }

  void _createAllScreens() {
    if(this._allEvents.length > 0) {
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
    } else {
      this._allTabs.add(Tab(child: Text('Erro')));
      this._screens.add(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              'Não foram encontrados eventos.\nTente pesquisar novamente!',
              style: const TextStyle(
                fontSize: 20
              ),
              textAlign: TextAlign.center
            )
          )
        )
      );
    }
  }

  @override
  void initState() {
    this._getEvents();
    super.initState();
  }

  Widget _returnSearchType(double _width) {
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Center(
            child: TextField(
              controller: this._searchFieldController,
              onChanged: (text) {
                if(text == ' ') text = '';
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 25.0, color: Colors.black),
              focusNode: this._focusNode,
              onSubmitted: (value) {
                this._searchEvent(this._searchFieldController.text);
                print(this._screens.length);
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
            child: this.isSearching ? this._returnSearchType(size.width) : Text('Eventos')
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              tabs: this._allTabs.toList(),
              isScrollable: true
            )
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(this.isSearching ? Icons.cancel : Icons.search_rounded),
              onPressed: () {
                if(this.isSearching) {
                  setState(() => isSearching = false);
                  this._resetAllScreens();
                  this._searchFieldController.text = '';
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
    if(query == '') return;

    final suggestions = this._allEvents.where((event) {
      final eventTitle = event.title.toLowerCase();
      final input = query.toLowerCase();

      return eventTitle.contains(input);
    }).toList();

    this._removeAllScreens();
    this._allEvents = suggestions;
    this._createAllScreens();
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