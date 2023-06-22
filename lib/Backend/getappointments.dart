import 'package:pet_paradise/models/message.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AppointmentNotifier {
  Future<List<dynamic>> getappointments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/getappointments'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of doctors
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch doctors');
    }
  }
}
