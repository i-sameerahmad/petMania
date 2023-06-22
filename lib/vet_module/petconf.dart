import 'package:flutter/material.dart';

class PetConfirmation extends StatelessWidget {
  const PetConfirmation({super.key});

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
