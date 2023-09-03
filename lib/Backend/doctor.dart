import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pet_mania/vet_module/vatConfirmation.dart';

class DoctorNotifier {
  Future<List<dynamic>> fetchDoctors() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getdoctor'));

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

  Future<List<dynamic>> fetchDoctor(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getdoctor/$id'));

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

  Future<dynamic> fetchDocId(String email) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getdoctorid/$email'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);

      // Return the list of doctors
      return data;
    }
  }

  Future<dynamic> doneapp(BuildContext context, int id) async {
    final response = await http.post(Uri.parse('http://192.168.1.102:8000/api/doneapp/$id'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final snackBar = SnackBar(
        content: Text("Marked as done"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Failed"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> addAppointment(String description, String user_name, File? image, String date, int userId, int doctorId) async {
    try {
      // Prepare the request body
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.102:8000/api/addAppointment'), // Replace with your actual API endpoint
      );
      request.fields['description'] = description;
      request.fields['date'] = date;
      request.fields['userId'] = userId.toString();
      request.fields['user_name'] = user_name.toString();
      request.fields['doctorId'] = doctorId.toString();

      if (image != null) {
        String fileName = image.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath('image', image.path, filename: fileName));
      }

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        print("appointment done");
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => VatConfirmation()),
        );
      } else {
        // Request failed
        // Handle the error or display an error message
      }
    } catch (e) {
      // Handle any exceptions or errors
    }
  }
}
