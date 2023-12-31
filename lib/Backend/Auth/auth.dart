import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_mania/Commons/DoctorHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pet_mania/Commons/commonHomeScreen.dart';
import 'package:pet_mania/models/user.dart';

class AuthNotifier {
  Future register(String email, password, name, context) async {
    User user;
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };

    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse("http://192.168.1.102:8000/api/auth/register"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ).timeout(const Duration(seconds: 10)); // Set a timeout of 10 seconds

      String responseBody = utf8.decoder.convert(response.bodyBytes);
      final jsonResponse = convert.jsonDecode(responseBody) as Map<String, dynamic>;

      if (jsonResponse['status']) {
        user = User.fromJson(json.decode(responseBody));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("status", jsonResponse['status']);
        prefs.setInt("userID", jsonResponse['user']['id']);
        prefs.setInt("userType", jsonResponse['user']['user_type']);
        prefs.setString("userName", jsonResponse['user']['name']);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CommonDashBoard()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              user.message,
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonResponse['errors']['email'][0],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'AirbnbCereal',
              ),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      // Handle timeout error
      print("Request timed out: $e");
    } finally {
      client.close();
    }
  }

  Future login(String email, password, context) async {
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse("http://192.168.1.102:8000/api/auth/login"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ).timeout(const Duration(seconds: 10)); // Set a timeout of 10 seconds

      String responseBody = utf8.decoder.convert(response.bodyBytes);
      final jsonResponse = convert.jsonDecode(responseBody) as Map<String, dynamic>;

      if (jsonResponse['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("status", jsonResponse['status']);
        prefs.setInt("userID", jsonResponse['user']['id']);
        prefs.setString("userName", jsonResponse['user']['name']);
        prefs.setInt("userType", jsonResponse['user']['user_type']);

        final snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (jsonResponse['user']['user_type'] == 2) {
          print("user");
          print(jsonResponse['user']['id']);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CommonDashBoard(),
            ),
          );
        } else if (jsonResponse['user']['user_type'] == 3) {
          print("doctor");

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const DoctorHomeScreen(),
            ),
          );
        } else {
          final snackBar = SnackBar(
            content: Text("Invalid user"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const CommonDashBoard(),
        //   ),
        // );
      } else {
        final snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Handle timeout error
      print("Request timed out: $e");
    } finally {
      client.close();
    }
  }

  Future<String> fetchNames(String otherParticipantId) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getNames/$otherParticipantId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final username = data[0];
      // print(username);
      return username;
    } else {
      throw Exception('Failed to fetch username');
    }
  }
}
