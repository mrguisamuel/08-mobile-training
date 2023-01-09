import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/game'),
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Iniciar Jogo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),
            TextButton(
              onPressed: null,
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Listar Recordes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),
            TextButton(
              onPressed: null,
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Compartilhar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),
          ]
        )
      )
    );
  }
}