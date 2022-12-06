import 'package:http/http.dart' as http;
import 'dart:core';
import 'models.dart';

class EventService {
  Future<List<Events>> getEvents() async {
    var values = await http.get(Uri.parse('https://spskills-events.azurewebsites.net/eventos'));

    // 200 = HTTP GET status code OK
    if(values.statusCode == 200) {
      var result = response.body as Map<String, dynamic>;
      return Events.fromJson(result);
    } else throw Exception('Failed to load events');
  }
}