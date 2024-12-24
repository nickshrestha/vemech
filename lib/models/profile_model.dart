import 'dart:convert';

class ProfileModel {
  ProfileData profileData;

  ProfileModel({
    required this.profileData,
  });

  factory ProfileModel.fromJson(String str) => ProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
    profileData: ProfileData.fromMap(json["profile_data"]),
  );

  Map<String, dynamic> toMap() => {
    "profile_data": profileData.toMap(),
  };
}

class ProfileData {
  int id;
  User user;
  String role;
  int phoneNo;
  String address;
  bool isActive;
  String? workshopName; // Nullable
  String? category;     // Nullable
  int? panNo;           // Nullable
  DateTime? dob;        // Nullable (Date of Birth)

  ProfileData({
    required this.id,
    required this.user,
    required this.role,
    required this.phoneNo,
    required this.address,
    required this.isActive,
    this.workshopName,    // Nullable
    this.category,        // Nullable
    this.panNo,           // Nullable
    this.dob,             // Nullable
  });

  factory ProfileData.fromJson(String str) => ProfileData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileData.fromMap(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    user: User.fromMap(json["user"]),
    role: json["role"] ?? "Workshop",
    phoneNo: json["phone_no"] ?? 000000,
    address: json["address"]?? "",
    isActive: json["is_active"] ?? false,
    workshopName: json["workshop_name"],  // Nullable
    category: json["category"],           // Nullable
    panNo: json["pan_no"],                // Nullable
    dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null, // Nullable
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user": user.toMap(),
    "role": role,
    "phone_no": phoneNo,
    "address": address,
    "is_active": isActive,
    "workshop_name": workshopName,  // Nullable
    "category": category,           // Nullable
    "pan_no": panNo,                // Nullable
    "dob": dob != null ? "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}" : null, // Nullable
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

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    email: json["email"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
  };
}
