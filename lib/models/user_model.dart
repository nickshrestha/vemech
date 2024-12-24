import 'package:meta/meta.dart';
import 'dart:convert';

class UserNameModel {
    List<String> usernames;

    UserNameModel({
        required this.usernames,
    });

    factory UserNameModel.fromRawJson(String str) => UserNameModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserNameModel.fromJson(Map<String, dynamic> json) => UserNameModel(
        usernames: List<String>.from(json["usernames"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "usernames": List<dynamic>.from(usernames.map((x) => x)),
    };
}
