import 'package:flutter/material.dart';
import 'game.dart' show Game;
import 'my_widgets.dart';

class Init extends StatelessWidget {
  const Init({super.key});

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
              Button(
                message: 'Iniciar um jogo normal',
                width: size.width * 0.8,
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game()
                    )
                  );
                }
              ),
              Button(
                message: 'Iniciar um jogo customizado',
                width: size.width * 0.8
              )
            ]
          )          
        )
      )
    );
  }
}