import 'package:flutter/material.dart';
import 'session.dart';
import 'my_widgets.dart';
import 'database.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  double averageReactTime() {
    if(Session.buttonSelectCounter == 0)
      return 0;
    else
      return Session.totalReactTime / Session.buttonSelectCounter;
  }

  double averageCorrectWords() {
    if(Session.buttonSelectCounter == 0)
      return 0;
    else
      return Session.correctWords / Session.totalWords;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              Text('Jogo Terminado!\n', textAlign: TextAlign.center),
              Text('Pontos: ${Session.points}\n', textAlign: TextAlign.center),
              Text('Tempo Médio de reação: ${this.averageReactTime()}\n', textAlign: TextAlign.center),
              Text('Média de acertos: ${this.averageCorrectWords()}\n', textAlign: TextAlign.center),
              Button(
                message: 'Compartilhar no Facebook',
                width: size.width * 0.8
              ),
              Button(
                message: 'Compartilhar no Twitter',
                width: size.width * 0.8
              ),
              Button(
                message: 'Ver a lista de high scores',
                width: size.width * 0.8
              ),
            ]
          )
        )
      )
    );
  }
}