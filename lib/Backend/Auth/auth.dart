import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/commonHomeScreen.dart';
import 'package:pet_paradise/models/user.dart';

class AuthNotifier {
  String? loginEmailError;
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
        Uri.parse("http://10.0.2.2:8000/api/auth/register"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ).timeout(Duration(seconds: 10)); // Set a timeout of 10 seconds

      String responseBody = utf8.decoder.convert(response.bodyBytes);
      final jsonResponse = convert.jsonDecode(responseBody) as Map<String, dynamic>;

      if (jsonResponse['status']) {
        user = User.fromJson(json.decode(responseBody));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("status", jsonResponse['status']);
        prefs.setInt("userID", jsonResponse['user']['id']);
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
        Uri.parse("http://10.0.2.2:8000/api/auth/login"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ).timeout(Duration(seconds: 10)); // Set a timeout of 10 seconds

      String responseBody = utf8.decoder.convert(response.bodyBytes);
      final jsonResponse = convert.jsonDecode(responseBody) as Map<String, dynamic>;

      if (jsonResponse['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("status", jsonResponse['status']);
        prefs.setInt("userID", jsonResponse['user']['id']);
        prefs.setString("userName", jsonResponse['user']['name']);

        final snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const CommonDashBoard(),
          ),
        );
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

  // ...
}
