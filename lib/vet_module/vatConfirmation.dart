import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/commonHomeScreen.dart';

class VatConfirmation extends StatefulWidget {
  // const VatConfirmation({required Key key}) : super(key: key);

  @override
  _VatConfirmationState createState() => _VatConfirmationState();
}

class _VatConfirmationState extends State<VatConfirmation> {
  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is created
    Timer(Duration(seconds: 2), () {
      // Navigate to the home screen after 2 seconds
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonDashBoard(), // Replace CartPage with your actual cart page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/VetConfirmation.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
