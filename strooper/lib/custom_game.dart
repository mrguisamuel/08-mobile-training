import 'package:flutter/material.dart';
import 'session.dart';
import 'my_widgets.dart' show Button;
import 'game.dart' show Game;

class CustomGame extends StatefulWidget {
  const CustomGame({Key? key}) : super(key: key);

  @override
  State<CustomGame> createState() => _CustomGameState();
}

class _CustomGameState extends State<CustomGame> {
  static const double sizeColors = 55;

  String? optionGame = 'number';
  String? optionColors = 'default';

  TextEditingController _numberWordsField = TextEditingController();
  TextEditingController _minutesField = TextEditingController();
  TextEditingController _secondsField = TextEditingController();
  TextEditingController _wordTimeField = TextEditingController();

  List<Widget> colors = [];

  @override
  void initState() {
    _numberWordsField.text = Session.numberWords.toString();
    _minutesField.text = '0';
    _secondsField.text = Session.seconds.toString();
    _wordTimeField.text = (Session.secondsPerWord * 1000).toString();
    _addOptions(Session.allColors);
    super.initState();
  }

  void _addOptions(Map<String, Color> _map) {
    _map.forEach((key, value) {
      colors.add(
        ColorOption(color: value, size: sizeColors)
      );
    });
  }

  void _goToGame() {
    Session.resetGame();

    // Test option (number of words or minutes and seconds)
    if(optionGame == 'number') {
      Session.numberOptionSelected = true;
      Session.numberWords = int.parse(_numberWordsField.text);
    } else {
      int m = int.parse(_minutesField.text);
      int s = int.parse(_secondsField.text);
      Session.seconds = (m * 60) + s;
    }

    int s = int.parse(_wordTimeField.text);
    // Convert from milliseconds to seconds
    double c = s / 1000;
    Session.secondsPerWord = c.round();

    int index = 0;
    List<String> colorName = [];
    for(String key in Session.allColors.keys) {
      ColorOption c = colors[index] as ColorOption;
      if(!c.checkboxValue) colorName.add(key);
      index++;
    }

    for(int i = 0; i < colorName.length; i++) {
      Session.allColors.remove(colorName[i]);
    }
    
    //Session.allColors.forEach((k, v) => print(k));
    Session.isDefaultGame = false;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Game()
      )
    );
  }

  Widget _createOptionColors(Map<String, MaterialColor> _map, double _size) {
    List<Widget> c = [];
    _map.forEach((key, value) {
      c.add(
        new Column(
          children: <Widget>[  
            Icon(
              Icons.adb_rounded,
              color: value,
              size: _size 
            ),
            Checkbox(
              value: true,
              onChanged: (bool? value) {

              }
            ) 
          ],
        ),
      );
    });
    return Row(children: colors);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar um jogo customizado')
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              RadioListTile(
                title: Text('Número de palavras'),
                value: 'number',
                groupValue: optionGame,
                onChanged: (value) => setState(() => optionGame = value.toString())
              ),
              RadioListTile(
                title: Text('Minutos e segundos'),
                value: 'time',
                groupValue: optionGame,
                onChanged: (value) => setState(() => optionGame = value.toString())
              ),
              Spacer(),
              Visibility(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: size.width / 4,
                      height: 40,
                      child: TextFormField(
                        controller: _minutesField,
                        decoration: InputDecoration(
                          hintText: 'Minutos',
                        ),
                        validator: (text) {
                          var n = int.parse(text ?? '0');
                          RegExp exp = new RegExp(r'^\d{1,}$');
                          if(!exp.hasMatch(text ?? '')) return 'Insira um número!';
                          else if(n > 60 || n <= 0) return 'Número inválido!';
                          return null;
                        },
                        keyboardType: TextInputType.number
                      )
                    ),
                    SizedBox(
                      width: size.width / 4,
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width / 4,
                      height: 40,
                      child: TextFormField(
                        controller: _secondsField,
                        decoration: InputDecoration(  
                          hintText: 'Segundos',
                        ),
                        validator: (text) {
                          var n = int.parse(text ?? '0');
                          RegExp exp = new RegExp(r'^\d{1,}$');
                          if(!exp.hasMatch(text ?? '')) return 'Insira um número!';
                          else if(n > 60 || n <= 0) return 'Número inválido!';
                          return null;
                        },
                        keyboardType: TextInputType.number
                      )
                    )
                  ]
                ),
                visible: optionGame == 'time'
              ),
              Visibility(
                child: SizedBox(
                  width: size.width * 0.8,
                  height: 40, 
                  child: TextFormField(
                    controller: _numberWordsField,
                    decoration: InputDecoration(
                      hintText: 'Número de palavras'
                    ),
                    validator: (text) {
                      var n = int.parse(text ?? '0');
                      RegExp exp = new RegExp(r'^\d{1,}$');
                      if(!exp.hasMatch(text ?? '')) return 'Insira um número!';
                      else if(n > 60 || n <= 0) return 'Número inválido!';
                      return null;
                    },
                    keyboardType: TextInputType.number
                  ),
                ),
                visible: optionGame == 'number'
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Text('Tempo de uma palavra (ms):'),
                  SizedBox(
                    width: size.width * 0.02,
                    height: 40, 
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    height: 40, 
                    child: TextFormField(
                      controller: _wordTimeField,
                      decoration: InputDecoration(
                        hintText: 'em milissegundos'
                      ),
                      validator: (text) {
                        var n = int.parse(text ?? '0');
                        RegExp exp = new RegExp(r'^\d{1,}$');
                        if(!exp.hasMatch(text ?? '')) return 'Insira um número!';
                        else if(n > 60 || n <= 0) return 'Número inválido!';
                        return null;
                      },
                      keyboardType: TextInputType.number
                    ),
                  ),
                ]
              ),
              Spacer(),
              Text('Cores'),
              RadioListTile(
                title: Text('Todas as cores'),
                value: 'default',
                groupValue: optionColors,
                onChanged: (value) => setState(() => optionColors = value.toString())
              ),
              RadioListTile(
                title: Text('Personalizado'),
                value: 'custom',
                groupValue: optionColors,
                onChanged: (value) => setState(() => optionColors = value.toString())
              ),
              Spacer(),
              //_createOptionColors(Session.allColors, 55),
              Visibility(
                child: Row(children: colors),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: optionColors == 'custom'
              ),
              Spacer(),
              Button(
                message: 'Iniciar Jogo Customizado',
                width: size.width * 0.9,
                action: () => _goToGame()
              )
            ]
          )
        )
      )
    );
  }
}

class ColorOption extends StatefulWidget {
  final Color? color;
  final double size;
  bool checkboxValue = true;

  ColorOption({
    Key? key,
    this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  /*
  bool? checkboxValue;

  @override
  void initState() {
    checkboxValue = true;
    super.initState();
  }
  */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[  
        Icon(
          Icons.adb_rounded,
          color: widget.color,
          size: widget.size 
        ),
        Checkbox(
          value: widget.checkboxValue,
          onChanged: (bool? value) => setState(() => widget.checkboxValue = value!)
        )
      ],
    );
  }
}