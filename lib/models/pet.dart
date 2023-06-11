import 'dart:convert';

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

class Pet {
  String title;
  String description;
  String gender;
  String category;
  String age;
  String price;
  String userId;
  String status;
  String image;
  String certificate;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Pet({
    required this.title,
    required this.description,
    required this.gender,
    required this.category,
    required this.age,
    required this.price,
    required this.userId,
    required this.status,
    required this.image,
    required this.certificate,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        title: json["title"],
        description: json["description"],
        gender: json["gender"],
        category: json["category"],
        age: json["age"],
        price: json["price"],
        userId: json["user_id"],
        status: json["status"],
        image: json["image"],
        certificate: json["certificate"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "gender": gender,
        "category": category,
        "age": age,
        "price": price,
        "user_id": userId,
        "status": status,
        "image": image,
        "certificate": certificate,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
