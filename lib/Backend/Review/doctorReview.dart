import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart' show rootBundle;

class DoctorReviewNotifier {
  Future<void> addReview(
    int userID,
    String userName,
    String review,
    double rating,
    int doctorId,
    BuildContext context,
  ) async {
    // Detect labels using Google Vision API
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/doctorReview'),
    );

    // Add text fields to the request
    request.fields['userId'] = userID.toString();
    request.fields['userName'] = userName;
    request.fields['review'] = review;
    request.fields['rating'] = rating.toStringAsFixed(2);
    request.fields['doctorId'] = doctorId.toString();

    // Add the PDF file to the request as a file attachment

    var response = await request.send();
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text('Review added Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Failed to add Review"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<dynamic>> fetchDoctorReviews(int doctorId) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/doctorReviews/$doctorId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return []; // Return an empty list if the request fails
    }
  }
}
