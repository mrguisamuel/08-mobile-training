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

class SelectEvent extends StatefulWidget {
  @override
  State<SelectEvent> createState() => _SelectEventState();
}

class _SelectEventState extends State<SelectEvent> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Digite um evento');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        leading: customIcon.icon == Icons.search ? const IconButton(
          icon: Icon(
            Icons.menu
          ),
          onPressed: null
        ) : null,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if(customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite um evento',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic
                        ),
                      )
                    )
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Digite um evento');
                }
              });
            }
          )
        ]
      ),
      body: EventListView()
    );
  }
}

/*
class MySearchBar extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => close(context, null)
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if(query.isEmpty)
          close(context, null);
        else
          query = '';
      }
    );
  }

  
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions 
  }
}
*/