import 'dart:convert';

class LoginModel {
  String token;
  int authUserId;
  Profile profile;

  LoginModel({
    required this.token,
    required this.authUserId,
    required this.profile,
  });

  factory LoginModel.fromJson(String str) => LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    token: json["token"] ?? '',
    authUserId: json["auth_user_id"] ?? 0,
    profile: Profile.fromMap(json["profile"] ?? {}),
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "auth_user_id": authUserId,
    "profile": profile.toMap(),
  };
}

class Profile {
  ProfileData? profileData;

  Profile({
    this.profileData,
  });

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    profileData: json["profile_data"] != null ? ProfileData.fromMap(json["profile_data"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "profile_data": profileData?.toMap(),
  };
}

class ProfileData {
  int id;
  User? user;
  String? role;
  int? phoneNo;
  String? address;
  bool? isActive;
  DateTime? dob;
  String? workshopName;
  String? category;
  int? panNo;

  ProfileData({
    required this.id,
    this.user,
    this.role,
    this.phoneNo,
    this.address,
    this.isActive,
    this.dob,
    this.workshopName,
    this.category,
    this.panNo,
  });

  factory ProfileData.fromJson(String str) => ProfileData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileData.fromMap(Map<String, dynamic> json) => ProfileData(
    id: json["id"] ?? 0,
    user: json["user"] != null ? User.fromMap(json["user"]) : null,
    role: json["role"],
    phoneNo: json["phone_no"],
    address: json["address"],
    isActive: json["is_active"],
    dob: json["dob"] != null ? DateTime.tryParse(json["dob"]) : null,
    workshopName: json["workshop_name"],
    category: json["category"],
    panNo: json["pan_no"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user": user?.toMap(),
    "role": role,
    "phone_no": phoneNo,
    "address": address,
    "is_active": isActive,
    "dob": dob != null ? "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}" : null,
    "workshop_name": workshopName,
    "category": category,
    "pan_no": panNo,
  };
}

class User {
  String email;
  String username;
  String? firstName;
  String? lastName;

  User({
    required this.email,
    required this.username,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    email: json["email"] ?? '',
    username: json["username"] ?? '',
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
