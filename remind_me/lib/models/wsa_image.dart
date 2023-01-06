import 'dart:typed_data';

class WSAImage {
  final String title;
  final String location;
  final String time;
  final String date;
  final Uint8List image;
  final Uint8List audio;

  const WSAImage({
    required this.title,
    required this.location,
    required this.time,
    required this.date,
    required this.image,
    required this.audio
  });

  factory WSAImage.fromMap(Map<String, dynamic> map) => WSAImage(
    title: map['title'],
    location: map['location'],
    image: map['image'],
    audio: map['audio'],
    time: map['time'],
    date: map['date']
  );

  Map<String, dynamic> toMap() => {
    'title': this.title,
    'location': this.location,
    'image': this.image,
    'audio': this.audio,
    'time': this.time,
    'date': this.date
  };
}