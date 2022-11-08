import 'package:flutter/material.dart';
import 'game.dart' show Game;
import 'my_widgets.dart';
import 'high_score.dart';
import 'custom_game.dart';
import 'session.dart';

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var brightness = MediaQuery.platformBrightnessOf(context);

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
                  Session.resetGame(brightness == Brightness.light ? true : false);
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
                width: size.width * 0.8,
                action: () {
                  Session.resetGame(brightness == Brightness.light ? true : false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomGame()
                    )
                  );
                }
              ),
              Button(
                message: 'Ver a lista de high scores',
                width: size.width * 0.8,
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HighScore()
                    )
                  );
                }
              )
            ]
          )          
        )
      )
    );
  }
}