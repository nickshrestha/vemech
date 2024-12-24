import 'dart:convert';

class ListWorkshopsTimeSchedule {
    int id;
    User user;
    String role;
    String category;
    int panNo;
    List<Schedule> schedules;
    List<dynamic> geoCoordinates;

    ListWorkshopsTimeSchedule({
        required this.id,
        required this.user,
        required this.role,
        required this.category,
        required this.panNo,
        required this.schedules,
        required this.geoCoordinates,
    });

    factory ListWorkshopsTimeSchedule.fromRawJson(String str) => ListWorkshopsTimeSchedule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListWorkshopsTimeSchedule.fromJson(Map<String, dynamic> json) => ListWorkshopsTimeSchedule(
        id: json["id"],
        user: User.fromJson(json["user"]),
        role: json["role"],
        category: json["category"],
        panNo: json["pan_no"],
        schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
        geoCoordinates: List<dynamic>.from(json["geo_coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "role": role,
        "category": category,
        "pan_no": panNo,
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
        "geo_coordinates": List<dynamic>.from(geoCoordinates.map((x) => x)),
    };
}

class Schedule {
    int id;
    DateTime date;
    String startTime;
    String endTime;
    int slots;

    Schedule({
        required this.id,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.slots,
    });

    factory Schedule.fromRawJson(String str) => Schedule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        slots: json["slots"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "slots": slots,
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
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
    };
}
