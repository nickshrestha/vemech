import 'package:meta/meta.dart';
import 'dart:convert';

class WorkshopRecommendationModel {
    int id;
    User user;
    String workshopName;
    String category;
    int panNo;

    WorkshopRecommendationModel({
        required this.id,
        required this.user,
        required this.workshopName,
        required this.category,
        required this.panNo,
    });

    factory WorkshopRecommendationModel.fromRawJson(String str) => WorkshopRecommendationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WorkshopRecommendationModel.fromJson(Map<String, dynamic> json) => WorkshopRecommendationModel(
        id: json["id"],
        user: User.fromJson(json["user"]),
        workshopName: json["workshop_name"] ?? "",
        category: json["category"] ?? "N/A",
        panNo: json["pan_no"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "workshop_name": workshopName,
        "category": category,
        "pan_no": panNo,
    };
}

class User {
    String email;
    String username;
    String firstName;
    String lastName;

    User({
        required this.email,
        required this.username,
        required this.firstName,
        required this.lastName,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        username: json["username"],
        firstName: json["first_name"] == "" ? "N/A":  json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
    };
}
