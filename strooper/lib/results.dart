import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Text('Jogo Terminado!\nResultados:\nPontos:\nTempo Médio:\n'),
            ]
          )
        )
      )
    );
  }
}