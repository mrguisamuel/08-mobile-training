import 'package:http/http.dart' as http;
import 'dart:core';
import 'models.dart';

class EventService {
  Future<List<Event>> getEvents() async {
    var values = await http.get(Uri.parse('https://spskills-events.azurewebsites.net/eventos'));

    // 200 = HTTP GET status code OK
    if(values.statusCode == 200) {
      var result = values.body;
      return eventsFromJson(result);
    } else throw Exception('Failed to load events');
  }
}