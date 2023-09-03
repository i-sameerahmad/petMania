import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoneAppointments extends StatefulWidget {
  @override
  _DoneAppointmentsState createState() => _DoneAppointmentsState();
}

class _DoneAppointmentsState extends State<DoneAppointments> {
  List<dynamic> _appointments = [];
  late int userID;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await myPrefs(); // Wait for myPrefs to complete
    await fetchAppointments(); // Wait for fetchAppointments to complete
  }

  Future<void> myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  }

  Future<void> fetchAppointments() async {
    try {
      print(userID);
      final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/fetchdoneapp/$userID'));
      if (response.statusCode == 200) {
        setState(() {
          _appointments = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch appointments');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final appointment = _appointments[index];
          return Card(
            child: ListTile(
              title: Text(appointment['description']),
              subtitle: Text(appointment['date']),
              leading: Text(appointment['user_name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appointment['status']),
                  // IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     _deleteAppointment(index);
                  //   },
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
