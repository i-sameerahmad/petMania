import 'package:http/http.dart' as http;

class OrderNotifier {
  Future<void> handleCheckout(List<int> productIds, List<int> quantities, int userId, int total,
      {required String name, required String address, required String phone, required String email, required String paymentMethod}) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/checkout');

    // Prepare the request body
    final body = {
      'productIds': productIds.join(','),
      'quantities': quantities.join(','),
      'userId': userId.toString(),
      'total': total.toString(),
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'paymentMethod': paymentMethod,
    };
    print(body);
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
