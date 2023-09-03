import 'package:flutter/material.dart';
import 'package:pet_mania/utils/size_config.dart';

void CustomProgressIndicatorDialog({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SizedBox(
            height: MyAppSize.height,
            width: MyAppSize.width,
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      });
}
