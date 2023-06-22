import 'package:pet_paradise/models/message.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MessageNotifier {
  Future<void> message(String content, senderId, recipientId, context) async {
    Message message;
    final Map<String, String> body = {
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
    };
    final response = await http.post(Uri.parse("http://10.0.2.2:8000/api/message"), body: body, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    String responseBody = utf8.decoder.convert(response.bodyBytes);
    final jsonResponse = convert.jsonDecode(responseBody) as Map<String, dynamic>;
    print(jsonResponse);
  }

  // Future<List<dynamic>> getMessages(
  //     {required int uid, required int rid}) async {
  //   final response = await http
  //       .get(Uri.parse('http://10.0.2.2:8000/api/getmessages/$uid/$rid'));

  //   if (response.statusCode == 200) {
  //     // If the request is successful, parse the response body
  //     final data = jsonDecode(response.body);
  //     if (data is List) {
  //       // Return the list of doctors
  //       // return data;
  //       final Messages = data
  //           .map((row) => Message(
  //                 messageId: row['id'],
  //                 senderId: row['senderId'],
  //                 recipientId: row['recipientId'],
  //                 content: row['content'],
  //                 timestamp: DateTime.parse(row['timestamp']),
  //               ))
  //           .toList();

  //       return Messages;
  //     } else {
  //       // Handle the case where the response body is not a list
  //       throw Exception('Invalid response format');
  //     }
  //   } else {
  //     // If the request fails, throw an exception or handle the error accordingly
  //     throw Exception('Failed to fetch doctors');
  //   }
  // }
  Future<List<dynamic>> getMessages({required int uid, required int rid}) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/getmessages/$uid/$rid'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        final messages = data
            .map((row) => Message(
                  messageId: row['id'],
                  senderId: row['senderId'],
                  recipientId: row['recipientId'],
                  content: row['content'],
                  timestamp: DateTime.parse(row['created_at']),
                ))
            .toList();

        return messages;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else if (response.statusCode == 204) {
      // If the response is empty, return an empty list
      return [];
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch messages');
    }
  }
}
