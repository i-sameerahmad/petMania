

import 'package:flutter/material.dart';

class CartConfirmation extends StatelessWidget {
  const CartConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/Order Confirmation.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
