import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductNotifier {
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getproducts'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of doctors
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch doctors');
    }
  }

  Future<List<dynamic>> fetchProduct(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getproduct/$id'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of doctors
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch doctors');
    }
  }
}
