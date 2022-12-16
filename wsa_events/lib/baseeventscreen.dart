import 'package:flutter/material.dart';
import 'models.dart';

class BaseEventScreen extends StatelessWidget {
  final Event event;

  const BaseEventScreen({
    Key? key,
    required this.event
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(event.title)
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Text(
                'Descrição:', 
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(event.description),
              SizedBox(height: size.height * 0.03),
              Text(
                'Horário e dia: ', 
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(event.date + ', ' + event.hour),
              SizedBox(height: size.height * 0.03),
              ParticipantListView(event: this.event, type: 'AVALIADOR', title: 'Avaliadores'),
              ParticipantListView(event: this.event, type: 'AVALIADOR_ADJUNTO', title: 'Avaliadores Adjuntos'),
              ParticipantListView(event: this.event, type: 'TREINADOR', title: 'Treinadores'),
            ]
          )
        )
      )
    );
  }
}

class ParticipantListView extends StatelessWidget {
  final Event event;
  final String title;
  final String type;

  ParticipantListView({
    Key? key,
    required this.event,
    required this.title,
    required this.type
  }) : super(key: key);

  int _countParticipantsOfType() {
    int count = 0;
    this.event.participants.forEach((value) {
      if(value.type == this.type) count++;
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            this.title + ':', 
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: this._countParticipantsOfType() > 0 ? ListView.builder(
              itemCount: event.participants.length,
              itemBuilder: (context, index) {
                if(event.participants[index].type == this.type) {
                  return ListTile(
                    title: Text(event.participants[index].name)
                  );
                } else return Container(width: 0, height: 0);
              }
            ) : ListTile(title: Text('Sem participantes.'))
          )
        ]
      ) 
    );
  }
}