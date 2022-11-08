import 'package:flutter/material.dart';
import 'my_widgets.dart';
import 'dart:math';
import 'dart:async';
import 'utility.dart';
import 'session.dart';
import 'results.dart';

class Game extends StatefulWidget {
  const Game({super.key});
  
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Color currentColor = Color(0xFFFFFFFF);
  String currentKey = '';
  GlobalKey<TimerProgressBarState> _key = GlobalKey<TimerProgressBarState>();
  List<Map<String, Object?>> answers = [];
  int _counterWord = 0;

  @override
  void initState() {
    //Session.resetGame();
    this.nextRound(false);
    super.initState();
  }

  void nextRound(bool someButtonPressed) {
    var keys = Session.allColors.keys.toList();
    var randValue = keys[Random().nextInt(Session.allColors.length)];
    this.currentKey = randValue;
    randValue = keys[Random().nextInt(Session.allColors.length)];
    this._key.currentState?.resetProgressBar();
    if(!someButtonPressed) Session.removePoints(1);
    setState(() => currentColor = Session.allColors[randValue] ??= Color(0xFF000000));
    Session.totalWords++;

    // Only for custom game
    if(Session.numberOptionSelected) {
      Session.numberWords--;
      if(Session.numberWords <= 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Results()
          )
        );
      }
    }
  }

  void testColor(bool pressedEqual) {
    Session.buttonSelectCounter++;

    // Save last word
    Map<String, Object?> baseInfo = {};
    baseInfo['word'] = this.currentKey;
    
    int percentage = this._key.currentState?.getCurrentValue() ?? 0;
    double s = (Session.secondsPerWord * percentage) / 100;
    Session.totalReactTime += Utility.roundDouble(s, 2);
    baseInfo['percentage'] = 100 - percentage;
    String seconds = (3 - Utility.roundDouble(s, 2)).toString();
    baseInfo['seconds'] = seconds.characters.take(4);

    Color? tc = Session.allColors[currentKey];
    
    bool isEqual = tc == currentColor ? true : false;

    if((pressedEqual && isEqual) || (!pressedEqual && !isEqual)) {
      Session.addPoints(1);
      baseInfo['correct'] = true;
      Session.correctWords++;
      //print('correct answer');
    } else {
      Session.removePoints(1);
      baseInfo['correct'] = false;
      //print('wrong answer');
    }
    //this.answers.add(baseInfo);
    // Inverse the array to display in ListView
    this.answers.insert(0, baseInfo);
    nextRound(true);
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
              Visibility(
                child: TimerProgressBar(
                  durationSeconds: Session.seconds, 
                  width: size.width * 0.8,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Results()),
                    );
                  },
                  doNotStart: Session.numberOptionSelected
                ),
                visible: !Session.numberOptionSelected
              ),
              Visibility(
                child: Text('Número de palavras restantes: ' + Session.numberWords.toString()),
                visible: Session.numberOptionSelected
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Text(
                'Pontos: ' + Session.points.toString()
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
                durationSeconds: Session.secondsPerWord, 
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
  final Color currentColor;

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