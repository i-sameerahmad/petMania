import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pet_mania/Commons/commonHomeScreen.dart';
import 'package:pet_mania/vet_module/bookingconf.dart';

class BookingNotifier {
  Future<void> booking(BuildContext context, int petId, int userId, int total, String name, String address, String phone, String email, String paymentMethod) async {
    final url = Uri.parse('http://192.168.1.102:8000/api/booking');

    // Prepare the request body
    final body = {
      'pet_id': petId.toString(),
      'user_id': userId.toString(),
      'price': total.toString(),
      'name': name,
      'address': address,
      'phone': phone.toString(),
      'email': email,
      'paymentMethod': paymentMethod,
    };
    print(petId);
    // Send the POST request
    final response = await http.post(url, body: body);

    // Handle the response
    if (response.statusCode == 200) {
      Navigator.of(context as BuildContext).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BookingConfirmation(),
        ),
      );
    } else {
      print(response);
    }
  }
}
