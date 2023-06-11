import 'package:flutter/material.dart';
import '../components/styles.dart';

class MyElevatedButton extends StatelessWidget {
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final text;
  final colors;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.colors,
    this.height = 50.0,
    this.gradient = const LinearGradient(colors: [appColor, appColor2]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: colors,
          shadowColor: appColor,
          elevation: 3,
          shape: (RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
        ),
        child: Text(
          text,
          style: const TextStyle(fontFamily: 'bold'),
        ),
      ),
    );
  }
}
