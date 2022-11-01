import 'package:flutter/material.dart';
import 'database.dart';
import 'init.dart' show Init;

class HighScore extends StatelessWidget {
  HighScore({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
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
        title: const Text('High Scores!')
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
                  return Center(
                    child: ListTile(
                      title: Text('${index + 1}º - ' + 
                        '${snapshot.data![index].points} pontos' +
                        '\nMédia de palavras acertadas: ${snapshot.data![index].averageCorrectWords * 100}%'
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
    );
  }
}