import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_mania/Commons/commonHomeScreen.dart';

class PetConfirmation extends StatefulWidget {
  const PetConfirmation({super.key});

  // const VatConfirmation({required Key key}) : super(key: key);

  @override
  _PetConfirmationState createState() => _PetConfirmationState();
}

class _PetConfirmationState extends State<PetConfirmation> {
  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is created
    Timer(const Duration(seconds: 2), () {
      // Navigate to the home screen after 2 seconds
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CommonDashBoard(), // Replace CartPage with your actual cart page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/petConfirmation.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
