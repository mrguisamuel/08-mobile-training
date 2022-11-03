import 'package:flutter/material.dart';
import 'session.dart';
import 'my_widgets.dart' show Button;

class CustomGame extends StatefulWidget {
  const CustomGame({Key? key}) : super(key: key);

  @override
  State<CustomGame> createState() => _CustomGameState();
}

class _CustomGameState extends State<CustomGame> {
  String? optionGame = 'number';
  String? optionColors = 'default';

  Widget _createOptionColors(Map<String, MaterialColor> _map, double _size) {
    List<Widget> colors = [];
    _map.forEach((key, value) {
      colors.add(
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
                        decoration: InputDecoration(
                          hintText: 'Minutos',
                        )
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
                        decoration: InputDecoration(  
                          hintText: 'Segundos',
                        )
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
                    decoration: InputDecoration(
                      hintText: 'Digite o número de palavras aqui'
                    )
                  ),
                ),
                visible: optionGame == 'number'
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Text('Tempo de uma palavra: '),
                  SizedBox(
                    width: size.width * 0.05,
                    height: 40, 
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    height: 40, 
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'em milissegundos'
                      )
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
                child: Row(
                  children: <Widget>[
                    ColorOption(color: Colors.blue, size: 55),
                    ColorOption(color: Colors.blue, size: 55),
                    ColorOption(color: Colors.blue, size: 55),
                    ColorOption(color: Colors.blue, size: 55),
                    ColorOption(color: Colors.blue, size: 55),
                    ColorOption(color: Colors.blue, size: 55),
                  ]
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: optionColors == 'custom'
              ),
              Spacer(),
              Button(
                message: 'Iniciar Jogo Customizado',
                width: size.width * 0.9
              )
            ]
          )
        )
      )
    );
  }
}

class ColorOption extends StatefulWidget {
  final MaterialColor color;
  final double size;

  const ColorOption({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  bool checkboxValue = false;

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
          value: checkboxValue,
          onChanged: (bool? value) => setState(() => checkboxValue = value!)
        )
      ],
    );
  }
}