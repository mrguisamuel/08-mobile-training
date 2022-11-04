import 'package:flutter/material.dart';
import 'database.dart';
import 'init.dart' show Init;
import 'utility.dart';

class HighScore extends StatelessWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController( 
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Init()
                )
              );
            },
          ),
          title: const Text('High Scores!'),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.home, color: Colors.grey),
                child: Text('Jogos Normais')
              ),
              Tab(
                icon: Icon(Icons.home, color: Colors.grey),
                child: Text('Jogos Personalizados')
              ),
            ]
          )
        ),
        body: SafeArea(
          child: Center(
            child: FutureBuilder<List<Record>>(
              future: MyDatabase.instance.getAllRecords(),
              builder: (BuildContext context, AsyncSnapshot<List<Record>> snapshot) {
                if(!snapshot.hasData)
                  return CircularProgressIndicator();
                return snapshot.data!.isEmpty ?
                Center(child: Text('Sem recordes salvos ainda.')) :
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String gameState = snapshot.data![index].isDefaultGame == 0 ? 'Jogo Normal' : 'Jogo Personalizado' ;
                    return Center(
                      child: ListTile(
                        title: Text('${index + 1}º - ' + 
                          '${snapshot.data![index].points} pontos' +
                          '\nMédia de palavras acertadas: ' + 
                          '${Utility.roundDouble(snapshot.data![index].averageCorrectWords * 100, 2)}%\n' +
                          gameState + '\n' 
                        ),
                      )
                    );
                  }
                );
                /*
                ListView(
                  children: snapshot.data!.map((record) {
                    return Center(
                      child: ListTile(
                        title: Text('${record.points} pontos'),
                      )
                    );
                  }).toList(),
                );
                */
              }
            )
          )
        )
      )
    );
  }
}