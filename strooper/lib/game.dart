import 'package:flutter/material.dart';
import 'my_widgets.dart';
import 'dart:math';

class Game extends StatefulWidget {
  const Game({super.key});
  
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final Map<String, MaterialColor> allColors = {
    'Amarelo' : Colors.yellow,
    'Azul' : Colors.blue,
    'Laranja' : Colors.orange,
    'Vermelho' : Colors.red,
    'Verde' : Colors.green,
    'Roxo' : Colors.purple
  };

  MaterialColor currentColor = Colors.orange;
  String currentKey = 'Teste';

  void nextRound() {
    var keys = allColors.keys.toList();
    var randValue = keys[Random().nextInt(allColors.length)];
    currentKey = randValue;
    randValue = keys[Random().nextInt(allColors.length)];
    setState(() => currentColor = allColors[randValue] ??= Colors.orange);
  }

  void testColor(bool pressedEqual) {
    nextRound();

    MaterialColor? tc = allColors[currentKey];
    
    bool isEqual = tc == currentColor ? true : false;

    if((pressedEqual && isEqual) || (!pressedEqual && !isEqual)) print('Acertou!');
    else print('Errou!');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(  
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,  
            children: <Widget>[
              ShowColor(
                size: 150,
                currentColor: currentColor 
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Text(
                currentKey,
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Button(
                message: 'Iguais!',
                width: size.width * 0.8,
                action: () => testColor(true) 
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Button(
                message: 'Diferentes!',
                width: size.width * 0.8,
                action: () => testColor(false) 
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              /*
              CustomProgressBar(
                width: 200,
                value: 50,
                totalValue: 100
              )
              */
              TimerProgressBar(
                durationSeconds: 3, 
                width: size.width * 0.6,
                action: () => nextRound()
              )
            ]
          )
        )
      )
    );
  }
}

class ShowColor extends StatelessWidget {
  final double size;
  final MaterialColor currentColor;

  ShowColor({
    Key? key,
    required this.size,
    required this.currentColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      color: this.currentColor
    );
  }
}