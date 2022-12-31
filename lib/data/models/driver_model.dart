
import 'dart:convert';

// class Travel {
//     Travel({
//         required this.data,
//     });

//     List<Drivers> data;

//     factory Travel.fromJson(String str) => Travel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Travel.fromMap(Map<String, dynamic> json) => Travel(
//         data: List<Drivers>.from(json["data"].map((x) => Drivers.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//     };
// }

class Drivers {
  Drivers({
    required this.id,
    required this.inDate,
    this.outDate,
    required this.taken,
    required this.status,
    required this.currentLat,
    required this.currentLong,
    required this.userId,
    required this.vehicleId,
    this.createdAt,
    this.updatedAt,
    required this.vehicle,
    required this.user,
  });

  int id;
  String inDate;
  String? outDate;
  int taken;
  int status;
  double currentLat;
  double currentLong;
  int userId;
  int vehicleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Vehicle vehicle;
  User user;

  Drivers copyWith({
    int? id,
    String? inDate,
    String? outDate,
    int? taken,
    int? status,
    double? currentLat,
    double? currentLong,
    int? userId,
    int? vehicleId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Vehicle? vehicle,
    User? user,
  }) =>
      Drivers(
        id: id ?? this.id,
        inDate: inDate ?? this.inDate,
        outDate: outDate ?? this.outDate,
        taken: taken ?? this.taken,
        status: status ?? this.status,
        currentLat: currentLat ?? this.currentLat,
        currentLong: currentLong ?? this.currentLong,
        userId: userId ?? this.userId,
        vehicleId: vehicleId ?? this.vehicleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicle: vehicle ?? this.vehicle,
        user: user ?? this.user,
      );

  factory Drivers.fromJson(String str) => Drivers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Drivers.fromMap(Map<String, dynamic> json) => Drivers(
        id: json["id"],
        inDate: json["inDate"],
        outDate: json["outDate"],
        taken: json["taken"],
        status: json["status"],
        currentLat: double.parse(json["currentLat"]),
        currentLong: double.parse(json["currentLong"]),
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vehicle: Vehicle.fromMap(json["vehicle"]),
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "inDate": inDate,
        "outDate": outDate == null ? null : createdAt!.toIso8601String(),
        "taken": taken,
        "status": status,
        "currentLat": currentLat,
        "currentLong": currentLong,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "vehicle": vehicle.toMap(),
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.id,
    required this.admin,
    this.birthday,
    this.ci,
    required this.email,
    required this.gender,
    required this.name,
    this.phone,
    required this.licenseCategoryId,
    this.busId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int admin;
  String? birthday;
  String? ci;
  String email;
  int gender;
  String name;
  String? phone;
  int licenseCategoryId;
  int? busId;
  String? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User copyWith({
    int? id,
    int? admin,
    String? birthday,
    String? ci,
    String? email,
    int? gender,
    String? name,
    String? phone,
    int? licenseCategoryId,
    int? busId,
    String? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        admin: admin ?? this.admin,
        birthday: birthday ?? this.birthday,
        ci: ci ?? this.ci,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        licenseCategoryId: licenseCategoryId ?? this.licenseCategoryId,
        busId: busId ?? this.busId,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        admin: json["admin"],
        birthday: json["birthday"],
        ci: json["ci"],
        email: json["email"],
        gender: json["gender"],
        name: json["name"],
        phone: json["phone"],
        licenseCategoryId: json["license_category_id"],
        busId: json["bus_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "admin": admin,
        "birthday": birthday,
        "ci": ci,
        "email": email,
        "gender": gender,
        "name": name,
        "phone": phone,
        "license_category_id": licenseCategoryId,
        "bus_id": busId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": createdAt,
      };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.contact,
    this.photo,
    required this.plate,
    required this.seats,
    required this.busId,
    required this.carModelId,
    this.createdAt,
    this.updatedAt,
  });
  int id;
  String contact;
  String? photo;
  String plate;
  int seats;
  int busId;
  int carModelId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehicle copyWith({
    int? id,
    String? contact,
    String? photo,
    String? plate,
    int? seats,
    int? busId,
    int? carModelId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Vehicle(
        id: id ?? this.id,
        contact: contact ?? this.contact,
        photo: photo ?? this.photo,
        plate: plate ?? this.plate,
        seats: seats ?? this.seats,
        busId: busId ?? this.busId,
        carModelId: carModelId ?? this.carModelId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
      id: json["id"],
      contact: json["contact"],
      photo: json["photo"],
      plate: json["plate"],
      seats: json["seats"],
      busId: json["bus_id"],
      carModelId: json["car_model_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt:
          json["update_at"] == null ? null : DateTime.parse(json["update_at"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "contact": contact,
        "photo": photo,
        "plate": plate,
        "seats": seats,
        "bus_id": busId,
        "car_model_id": carModelId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
