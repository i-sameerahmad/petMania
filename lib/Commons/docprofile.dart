import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfilePage extends StatefulWidget {
  // final int userId;

  // DoctorProfilePage({required this.userId});

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  Doctor? doctor;
  bool isLoading = true;
  late int userID;
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('userID'));
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  } // Added variable

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchDoctorData();
  }

  Future<void> fetchDoctorData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.102:8000/api/getdoctor/$userID'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          doctor = Doctor.fromJson(jsonResponse);
          isLoading = false;
        });
      } else {
        // Handle error case
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error case
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('doctor_profile_image.jpg'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    doctor!.docName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Email: ${doctor!.docEmail}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Phone: ${doctor!.docPhone}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Qualification: ${doctor!.docQualification}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Address: ${doctor!.docAddress}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Status: ${doctor!.docStatus}',
                    style: TextStyle(
                      fontSize: 18,
                      color: doctor!.docStatus == 'Active' ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Doctor {
  final int id;
  final String docName;
  final String docEmail;
  final int docPhone;
  final String docQualification;
  final String docAddress;
  final String docStatus;

  Doctor({
    required this.id,
    required this.docName,
    required this.docEmail,
    required this.docPhone,
    required this.docQualification,
    required this.docAddress,
    required this.docStatus,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      docName: json['doc_name'],
      docEmail: json['doc_email'],
      docPhone: json['doc_phone'],
      docQualification: json['doc_qualification'],
      docAddress: json['doc_address'],
      docStatus: json['doc_status'],
    );
  }
}
