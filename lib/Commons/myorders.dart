import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<dynamic> _orders = [];
  late int userID;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await myPrefs(); // Wait for myPrefs to complete
    await fetchorders(); // Wait for fetchorders to complete
  }

  Future<void> myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  }

  Future<void> fetchorders() async {
    try {
      print(userID);
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/getmyorders/$userID'));
      if (response.statusCode == 200) {
        setState(() {
          _orders = jsonDecode(response.body);
          print(_orders);
        });
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: _orders.map((order) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${order['name']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.9, // Adjust the width factor as needed
                      child: Stepper(
                        currentStep: 0, // Replace with the actual step index
                        controlsBuilder: (BuildContext context, ControlsDetails? controlsDetails) {
                          return Row(
                            children: [
                              ElevatedButton(
                                onPressed: controlsDetails?.onStepContinue,
                                child: Text('Next'),
                              ),
                              SizedBox(width: 16.0),
                              ElevatedButton(
                                onPressed: controlsDetails?.onStepCancel,
                                child: Text('Previous'),
                              ),
                            ],
                          );
                        },
                        steps: const [
                          Step(
                            title: Text('Pending'),
                            isActive: true, // Replace with the actual step status
                            content: SizedBox(),
                          ),
                          Step(
                            title: Text('Processing'),
                            isActive: false, // Replace with the actual step status
                            content: SizedBox(),
                          ),
                          Step(
                            title: Text('Shipped'),
                            isActive: false, // Replace with the actual step status
                            content: SizedBox(),
                          ),
                          Step(
                            title: Text('Delivered'),
                            isActive: false, // Replace with the actual step status
                            content: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 8.0),
                        Text(
                          '${order['phone']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(width: 8.0),
                        Text(
                          'Total: ${order['total']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8.0),
                        Text(
                          'Address: ${order['address']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.payment),
                        SizedBox(width: 8.0),
                        Text(
                          'Payment Method: ${order['paymentMethod']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
