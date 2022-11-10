import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Relembra-me'),
          bottom: TabBar(
            tabs: <Tab>[
              Tab(
                icon: const Icon(Icons.add_a_photo_rounded),
                child: const Text('Tirar foto')
              ),
              Tab(
                icon: const Icon(Icons.app_shortcut_rounded),
                child: const Text('Editar foto')
              )
            ]
          )
        ),
        body: SafeArea(
          child: const TabBarView(
            children: <Widget>[
              SizedBox(
                child: Text('oi')
              ),
              SizedBox(
                child: Text('fdsjhfjdshjfkh')
              )
            ]
          )
        )
      ),
    );
  }
}