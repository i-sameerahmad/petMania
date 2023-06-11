import 'package:flutter/material.dart';

class TrainerConfirmation extends StatelessWidget {
  const TrainerConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/TrainerConfirmation.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
