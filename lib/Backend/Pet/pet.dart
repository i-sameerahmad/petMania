import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:pet_mania/vet_module/petconf.dart';
import 'package:pet_mania/vet_module/vatConfirmation.dart';

List<String> pets = [
  "Cat",
  "Dog",
  "Horse",
  "Kitten",
  "Fish",
  "Duke",
  "Peacock",
  "Pigeon",
  "Molly",
  "Squeak",
  "Parrot",
  "Rabbit",
  "Porky",
  "Daisy",
  "Canary",
  "Parrot",
  "Macaw",
  "Snakey",
  "Turtle",
  "Leo",
];

class PetNotifier {
  Future<void> addPet(
    int userID,
    String title,
    String description,
    String gender,
    String category,
    int age,
    double price,
    File? image,
    String? certificatePath,
    String userName,
    String userAddress,
    String userPhone,
    String userEmail,
    BuildContext context,
  ) async {
    List<String> labels = await detectLabels(image);
    print(labels);
    List<String> commonPets = pets.where((pet) => labels.any((label) => label.trim().toLowerCase() == pet.trim().toLowerCase())).toList();

    print('Common Pets: $commonPets');
    if (commonPets.isEmpty) {
      const snackBar = SnackBar(content: Text('Please select an appropriate image.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.102:8000/api/pets'),
    );

    // Add text fields to the request
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['gender'] = gender;
    request.fields['category'] = category;
    request.fields['age'] = age.toString();
    request.fields['price'] = price.toString();
    request.fields['user_id'] = userID.toString();
    request.fields['image'] = image!.path.split('/').last;
    request.fields['user_name'] = userName.toString();
    request.fields['user_address'] = userAddress.toString();
    request.fields['user_phone'] = userPhone.toString();
    request.fields['user_email'] = userEmail.toString();

    // request.fields['labels'] = labels.join(','); // Add labels to the request

    // Add the PDF file to the request as a file attachment
    if (certificatePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'certificate',
        certificatePath,
        contentType: MediaType('application', 'pdf'),
      ));
    }
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        await File.fromUri(image.uri).readAsBytes(),
        filename: image.path.split('/').last,
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PetConfirmation(), // Replace CartPage with your actual cart page
        ),
      );
    } else {
      print('Failed to add pet.');
    }
  }

  Future<void> addAdoptPet(
    int userID,
    String title,
    String description,
    String gender,
    String category,
    int age,
    File? image,
    String userName,
    String userAddress,
    String userPhone,
    String userEmail,
    BuildContext context,
  ) async {
    List<String> labels = await detectLabels(image);
    print(labels);
    List<String> commonPets = pets.where((pet) => labels.any((label) => label.trim().toLowerCase() == pet.trim().toLowerCase())).toList();

    print('Common Pets: $commonPets');
    if (commonPets.isEmpty) {
      const snackBar = SnackBar(content: Text('Please select an appropriate image.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.102:8000/api/adoptpet'),
    );

    // Add text fields to the request
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['gender'] = gender;
    request.fields['category'] = category;
    request.fields['age'] = age.toString();
    request.fields['user_id'] = userID.toString();
    request.fields['image'] = image!.path.split('/').last;
    request.fields['user_name'] = userName.toString();
    request.fields['user_address'] = userAddress.toString();
    request.fields['user_phone'] = userPhone.toString();
    request.fields['user_email'] = userEmail.toString();
    // request.fields['labels'] = labels.join(','); // Add labels to the request

    // Add the PDF file to the request as a file attachment

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        await File.fromUri(image.uri).readAsBytes(),
        filename: image.path.split('/').last,
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VatConfirmation(), // Replace CartPage with your actual cart page
        ),
      );
    } else {
      print('Failed to add pet.');
    }
  }

  Future<List<dynamic>> fetchPets() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getpets'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<List<dynamic>> fetchVerifiedPets() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getverifiedpets'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<List<dynamic>> fetchAdoptPets() async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getadoptpets'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<dynamic> fetchPet(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getpet/$id'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<dynamic> fetchVarifiedPet(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getvarifiedpet/$id'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<dynamic> fetchAdoptPet(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getadoptpet/$id'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      final data = jsonDecode(response.body);
      if (data is List) {
        // Return the list of pets
        return data;
      } else {
        // Handle the case where the response body is not a list
        throw Exception('Invalid response format');
      }
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch pets');
    }
  }

  Future<List<String>> detectLabels(File? image) async {
    var imaggaApiKey = 'acc_62533afd05f6843';
    var imaggaApiSecret = 'df48d1abddb5bd5a92b8e97ddf63a560';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imagga.com/v2/tags'),
    );

    // Set authorization header
    request.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode("$imaggaApiKey:$imaggaApiSecret"))}';

    // Add image file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image!.path,
      contentType: MediaType('application', 'octet-stream'),
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var data = jsonDecode(responseData);
      var result = data['result'];
      if (result != null && result.containsKey('tags')) {
        var tags = result['tags'];
        if (tags is List) {
          var labels = tags.map<String>((tag) => tag['tag']['en'].toString()).toList();
          return labels;
        }
      }
    }

    // If the request fails or no labels are detected, return an empty list
    return [];
  }
}
