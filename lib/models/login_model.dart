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
        token: json["token"],
        authUserId: json["auth_user_id"],
        profile: Profile.fromMap(json["profile"]),
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "auth_user_id": authUserId,
        "profile": profile.toMap(),
    };
}

class Profile {
    ProfileData profileData;

    Profile({
        required this.profileData,
    });

    factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Profile.fromMap(Map<String, dynamic> json) => Profile(
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
    String workshopName;
    String category;
    int panNo;

    ProfileData({
        required this.id,
        required this.user,
        required this.role,
        required this.phoneNo,
        required this.address,
        required this.isActive,
        required this.workshopName,
        required this.category,
        required this.panNo,
    });

    factory ProfileData.fromJson(String str) => ProfileData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProfileData.fromMap(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        user: User.fromMap(json["user"]),
        role: json["role"],
        phoneNo: json["phone_no"],
        address: json["address"],
        isActive: json["is_active"],
        workshopName: json["workshop_name"],
        category: json["category"],
        panNo: json["pan_no"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user": user.toMap(),
        "role": role,
        "phone_no": phoneNo,
        "address": address,
        "is_active": isActive,
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
