import 'package:flutter/material.dart';
import 'session.dart';
import 'my_widgets.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  double meanReactTime() {
    return Session.totalReactTime / Session.buttonSelectCounter;
  }

  double meanCorrectWords() {
    return Session.correctWords / Session.totalWords;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Text('Jogo Terminado!\n
                Resultados:\n
                Pontos: ${Session.points}\n
                Tempo Médio de reação: ${this.meanReactTime()}\n
                Média de acertos: ${this.meanCorrectWords()}\n'
              ),
              Button(
                message: 'Compartilhar no Facebook',
                width: size.width * 0.8;
              ),
              Button(
                message: 'Compartilhar no Twitter',
                width: size.width * 0.8;
              ),
              Button(
                message: 'Ver a lista de high scores',
                width: size.width * 0.8;
              ),
            ]
          )
        )
      )
    );
  }
}