import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
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
      final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getbookings/$userID'));
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
        title: Text('My Bookings'),
      ),
      body: ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final appointment = _appointments[index];
          final String name = appointment['address'] ?? '';
          final String address = appointment['paymentMethod'] ?? '';
          final String paymentMethod = appointment['name'] ?? '';
          final String total = appointment['price'].toString() ?? '';

          return Card(
            child: ListTile(
              title: Text(name),
              subtitle: Text(address),
              leading: Text(paymentMethod),
              trailing: Text(total),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteAppointment(int index) async {
    final appointment = _appointments[index];
    final appointmentId = appointment['id']; // Assuming there's an 'id' field in the appointment data

    try {
      final response = await http.delete(Uri.parse('http://192.168.1.102:8000/api/deletepet/$appointmentId'));
      if (response.statusCode == 200) {
        setState(() {
          _appointments.removeAt(index);
        });
        final snackBar = SnackBar(
          content: Text("Pet deleted successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text("Failed to delete pet"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
