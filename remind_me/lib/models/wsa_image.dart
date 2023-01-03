import 'dart:typed_data';

class WSAImage {
  final String title;
  final String location;
  final String hour;
  final Uint8List image;
  final Uint8List audio;

  const WSAImage({
    required this.title,
    required this.location,
    required this.hour,
    required this.image,
    required this.audio
  });

  factory WSAImage.fromMap(Map<String, dynamic> map) => WSAImage(
    title: map['title'],
    location: map['location'],
    image: map['image'],
    audio: map['audio'],
    hour: map['hour']
  );

  Map<String, dynamic> toMap() => {
    'title': this.title,
    'location': this.location,
    'image': this.image,
    'audio': this.audio,
    'hour': this.hour
  };
}