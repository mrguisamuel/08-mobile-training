import 'package:flutter/material.dart';
import 'my_widgets.dart';

class Game extends StatefulWidget {
  const Game({super.key});
  
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

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
                currentColor: Colors.orange
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Text(
                'Teste',
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Button(
                message: 'Iguais!',
                width: size.width * 0.8
              ),
              SizedBox(
                height: size.height * 0.03
              ),
              Button(
                message: 'Diferentes!',
                width: size.width * 0.8
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