import 'dart:convert';

List<Participant> participantsFromJson(String receivedJson) => List<Participant>.from(
  jsonDecode(receivedJson).map((x) => Participant.fromJson(x))
);

class Participant {
  final String id;
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
    name: json['name'],
    about: json['about'],
    type: json['type']
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.name,
    'about': this.about,
    'type': this.type
  };
}

class Event {
  final String id;
  final String title;
  final String description;
  final List<Participant> participants;
  final String dateHour;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.participants,
    required this.dateHour
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    participants: participantsFromJson(json['participants']),
    dateHour: json['dateHour'],
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'description': this.description,
    'participants': this.participants,
    'dateHour': this.dateHour
  };
}