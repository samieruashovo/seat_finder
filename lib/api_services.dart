import 'package:seat_finder/api_endpoints.dart';

import 'models/events.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Event>> fetchEvents() async {
    final response =
        await http.get(Uri.parse(ApiEndPoints.baseUrl + 'api/events/'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['results'];
      List<Event> events =
          body.map((dynamic item) => Event.fromJson(item)).toList();
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }
}
