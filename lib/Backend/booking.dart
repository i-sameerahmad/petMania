import 'package:http/http.dart' as http;

class BookingNotifier {
  Future<void> booking(int petId, int userId, int total, String name, String address, String phone, String email, String paymentMethod) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/booking');

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
      print("hello");
    } else {
      print(response);
    }
  }
}
