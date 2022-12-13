import 'package:flutter/material.dart';
import 'globals.dart';
import 'utility.dart';

enum SearchType {
  title, description, participants
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedItem = Globals.allTypes[0];
  SearchType type = SearchType.title;
  /*
  Map<String, bool> checkboxes = {
    'Título': false,
    'Descrição': false,
    'Participantes': false
  }
  */

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text('Pesquisa')
        )
      ),
      body: SingleChildScrollView( 
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                /*
                SearchCheckbox(title: 'Título'),
                SearchCheckbox(title: 'Descrição'),
                SearchCheckbox(title: 'Participantes'),
                */
                RadioListTile<SearchType>(
                  title: Text('Título'),
                  value: SearchType.title,
                  groupValue: this.type,
                  onChanged: (SearchType? value) {
                    setState(() => this.type = value!);
                  }
                ),
                RadioListTile<SearchType>(
                  title: Text('Descrição'),
                  value: SearchType.description,
                  groupValue: this.type,
                  onChanged: (SearchType? value) {
                    setState(() => this.type = value!);
                  }
                ),
                RadioListTile<SearchType>(
                  title: Text('Participantes'),
                  value: SearchType.participants,
                  groupValue: this.type,
                  onChanged: (SearchType? value) {
                    setState(() => this.type = value!);
                  }
                ),
                Visibility(
                  child: SearchTextField(hint: 'Título'),
                  visible: this.type == SearchType.title
                ),
                Visibility(
                  child: SearchTextField(hint: 'Descrição'),
                  visible: this.type == SearchType.description
                ),
                //SearchTextField(hint: 'Participantes'),
                Visibility(
                  child: SizedBox(
                    height: 50,
                    width: size.width * 0.8,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: Globals.allTypes.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item.splitAndCapitalize('_').join(' ')) 
                      )).toList(),
                      onChanged: (item) => setState(() => this.selectedItem = item),
                      value: this.selectedItem
                    ),
                  ),
                  visible: this.type == SearchType.participants
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    child: Icon(Icons.search_rounded),
                    foregroundColor: Colors.white,
                    onPressed: null
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}

class SearchTextField extends StatelessWidget {
  final String hint;
  const SearchTextField({
    Key? key,
    required this.hint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: size.width * 0.8,
        height: 30,
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: this.hint
          ),
        )
      ),
    );
  }
}

/*
class SearchRadio extends StatefulWidget {
  final String title;
  
  const SearchRadio({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  State<SearchRadio> createState() => _SearchRadioState();
}
*/

class SearchCheckbox extends StatefulWidget {
  final String title;

  const SearchCheckbox({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  State<SearchCheckbox> createState() => _SearchCheckboxState();
}

class _SearchCheckboxState extends State<SearchCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() => isChecked = value!);
          }
        ),
        Text(widget.title),
      ]
    );
  }
}