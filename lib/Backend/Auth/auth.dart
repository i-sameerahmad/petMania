import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/commonHomeScreen.dart';
import 'package:pet_paradise/models/user.dart';

class AuthNotifer {
  // late UserModel userData;
  //function for User Registration
  // Future register(String email, password, name, context) async {
  //   User _user;
  //   final Map<String, String> body = {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //   };
  //   final response = await http.post(
  //       Uri.parse("http://10.0.2.2:8000/api/auth/register"),
  //       body: body,
  //       headers: {
  //         "Content-Type": "application/x-www-form-urlencoded",
  //       });
  //   String responseBody = utf8.decoder.convert(response.bodyBytes);
  //   _user = User.fromJson(json.decode(responseBody));

  //   if (_user.status) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => CommonDashBoard()),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           _user.message,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //             _user.message,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontFamily: 'AirbnbCereal',
  //             ),
  //           ),
  //           backgroundColor: Colors.black),
  //     );
  //   }
  // }
  Future register(String email, password, name, context) async {
    User user;
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/auth/register"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    String responseBody = utf8.decoder.convert(response.bodyBytes);
    final jsonResponse =
        convert.jsonDecode(responseBody) as Map<String, dynamic>;
    print(jsonResponse);
    if (jsonResponse['status']) {
      user = User.fromJson(json.decode(responseBody));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("status", jsonResponse['status']);
      prefs.setInt("userID", jsonResponse['user']['id']);
      prefs.setString("userName", jsonResponse['user']['name']);
      // await _prefs.setString('user', json.encode(_user));
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
            backgroundColor: Colors.black),
      );
    }
  }

//function for user login
  Future login(String email, password, context) async {
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/auth/login"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    String responseBody = utf8.decoder.convert(response.bodyBytes);

    final jsonResponse =
        convert.jsonDecode(responseBody) as Map<String, dynamic>;

    // String userData = _prefs.getString('user');
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
// // //function to logout User
//   logout(context) {
//     SharedPreferenceHelper _prefs = SharedPreferenceHelper();
//     _prefs.deletePrefs();
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const MyLogin()),
//     );

    //}
  }
}
