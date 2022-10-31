import 'package:flutter/material.dart';
import 'my_widgets.dart';
import 'dart:math';
import 'dart:async';
import 'utility.dart';

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

  static const gameTime = 30;
  static const wordTime = 3;

  MaterialColor currentColor = Colors.orange;
  String currentKey = '';
  int points = 0;
  GlobalKey<TimerProgressBarState> _key = GlobalKey<TimerProgressBarState>();
  List<Map<String, Object?>> answers = [];
  int _counterWord = 0;

  @override
  void initState() {
    this.nextRound(false);
    super.initState();
  }

  void nextRound(bool someButtonPressed) {
    var keys = allColors.keys.toList();
    var randValue = keys[Random().nextInt(allColors.length)];
    this.currentKey = randValue;
    randValue = keys[Random().nextInt(allColors.length)];
    this._key.currentState?.resetProgressBar();
    if(!someButtonPressed) this.removePoints(1);
    setState(() => currentColor = allColors[randValue] ??= Colors.orange);
  }

  void testColor(bool pressedEqual) {
    // Save last word
    Map<String, Object?> baseInfo = {};
    baseInfo['word'] = this.currentKey;
    
    int percentage = this._key.currentState?.getCurrentValue() ?? 0;
    double s = (wordTime * percentage) / 100;
    baseInfo['percentage'] = 100 - percentage;
    String seconds = (3 - Utility.roundDouble(s, 2)).toString();
    baseInfo['seconds'] = seconds.characters.take(4);

    MaterialColor? tc = allColors[currentKey];
    
    bool isEqual = tc == currentColor ? true : false;

    if((pressedEqual && isEqual) || (!pressedEqual && !isEqual)) {
      this.addPoints();
      baseInfo['correct'] = true;
      //print('correct answer');
    } else {
      this.removePoints(1);
      baseInfo['correct'] = false;
      //print('wrong answer');
    }
    //this.answers.add(baseInfo);

    // Inverse the array to display in ListView
    this.answers.insert(0, baseInfo);
    nextRound(true);
  }

  void addPoints() {
    this.points++;
  }

  void removePoints(int number_points) {
    if(this.points > 0) this.points -= number_points;
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
              TimerProgressBar(
                durationSeconds: gameTime, 
                width: size.width * 0.8,
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Text(
                'Pontos: ' + points.toString()
              ),
              SizedBox(
                height: size.height * 0.03
              ),
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
                key: this._key,
                durationSeconds: wordTime, 
                width: size.width * 0.6,
                action: () => nextRound(false),
                repeat: true
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.2,
                child: ListView.builder(
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    bool status = answers[index]['correct'] as bool;
                    return ListTile(
                      leading: status ? 
                      Icon(
                        Icons.assignment_turned_in_rounded,
                        color: Colors.green
                      ) : 
                      Icon(
                        Icons.assignment_late_rounded,
                        color: Colors.red
                      ),
                      title: Text(
                        '${answers[index]["word"]} - ${answers[index]["percentage"]}% - ${answers[index]["seconds"]} segundos'
                      )
                    );
                  }
                ),
              ),
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