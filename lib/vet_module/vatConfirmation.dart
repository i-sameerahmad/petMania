

import 'package:flutter/material.dart';

class VatConfirmation extends StatelessWidget {
  const VatConfirmation({super.key});

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
