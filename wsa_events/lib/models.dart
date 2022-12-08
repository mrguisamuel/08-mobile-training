import 'dart:convert';
import 'utility.dart';

List<Event> eventsFromJson(String receivedJson) => List<Event>.from(
  jsonDecode(receivedJson).map((x) => Event.fromJson(x))
);

class Participant {
  final int id;
  final String name;
  final String about;
  final String type;

  Participant({
    required this.id,
    required this.name,
    required this.about,
    required this.type
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json['id'],
    name: json['nome'],
    about: json['observacao'],
    type: json['tipo']
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.name,
    'about': this.about,
    'type': this.type
  };
}

class Event {
  final int id;
  final String title;
  final String description;
  final List<Participant> participants;
  final String dateHour;
  
  String get date => pickHourAndDate(this.dateHour)[1];
  String get hour => pickHourAndDate(this.dateHour)[0];

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.participants,
    required this.dateHour
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    title: json['evento'],
    description: json['descricao'],
    participants: List<Participant>.from(json['pessoa']?.map((x) => Participant.fromJson(x)) ?? const []),
    dateHour: json['dataHora'],
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'description': this.description,
    'participants': this.participants,
    'dateHour': this.dateHour
  };
}