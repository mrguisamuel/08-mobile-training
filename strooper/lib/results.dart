import 'package:flutter/material.dart';
import 'session.dart';
import 'my_widgets.dart';
import 'database.dart';
import 'utility.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  double averageReactTime() {
    if(Session.buttonSelectCounter == 0)
      return 0;
    else
      return Utility.roundDouble(Session.totalReactTime / Session.buttonSelectCounter, 2);
  }

  double averageCorrectWords() {
    if(Session.buttonSelectCounter == 0)
      return 0;
    else
      return Utility.roundDouble(Session.correctWords / Session.totalWords, 2);
  }

  Future<void> updateDatabase() async {
    await MyDatabase.instance.insertRecord(
      Record(
        points: Session.points,
        averageReactTime: this.averageReactTime(),
        averageCorrectWords: this.averageCorrectWords()
      )
    );
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
              Text('Tempo Médio de Reação: ${this.averageReactTime()}\n', textAlign: TextAlign.center),
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
                message: 'Salvar pontuação',
                width: size.width * 0.8,
                action: () async => updateDatabase()
              ),
            ]
          )
        )
      )
    );
  }
}