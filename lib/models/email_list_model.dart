import 'package:meta/meta.dart';
import 'dart:convert';

class EmailModel {
    List<String> emails;

    EmailModel({
        required this.emails,
    });

    factory EmailModel.fromRawJson(String str) => EmailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmailModel.fromJson(Map<String, dynamic> json) => EmailModel(
        emails: List<String>.from(json["emails"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "emails": List<dynamic>.from(emails.map((x) => x)),
    };
}
