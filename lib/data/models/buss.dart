// To parse this JSON data, do
//
//     final bus = busFromMap(jsonString);

// import 'dart:convert';

// class Bus {
//     Bus({
//         this.bus,
//         this.paths,
//     });

//     BusClass bus;
//     Paths paths;

//     factory Bus.fromJson(String str) => Bus.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Bus.fromMap(Map<String, dynamic> json) => Bus(
//         bus: BusClass.fromMap(json["bus"]),
//         paths: Paths.fromMap(json["paths"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "bus": bus.toMap(),
//         "paths": paths.toMap(),
//     };
// }

// class BusClass {
//     BusClass({
//         this.id,
//         this.color,
//         this.name,
//         this.photo,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int id;
//     String color;
//     String name;
//     dynamic photo;
//     int status;
//     dynamic createdAt;
//     dynamic updatedAt;

//     factory BusClass.fromJson(String str) => BusClass.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory BusClass.fromMap(Map<String, dynamic> json) => BusClass(
//         id: json["id"],
//         color: json["color"],
//         name: json["name"],
//         photo: json["photo"],
//         status: json["status"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "color": color,
//         "name": name,
//         "photo": photo,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// class Paths {
//     Paths({
//         this.ida,
//         this.vuelta,
//     });

//     List<Ida> ida;
//     List<Ida> vuelta;

//     factory Paths.fromJson(String str) => Paths.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Paths.fromMap(Map<String, dynamic> json) => Paths(
//         ida: List<Ida>.from(json["ida"].map((x) => Ida.fromMap(x))),
//         vuelta: List<Ida>.from(json["vuelta"].map((x) => Ida.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
//         "ida": List<dynamic>.from(ida.map((x) => x.toMap())),
//         "vuelta": List<dynamic>.from(vuelta.map((x) => x.toMap())),
//     };
// }

// class Ida {
//     Ida({
//         this.id,
//         this.latitude,
//         this.longitude,
//         this.busId,
//         this.comingBack,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int id;
//     String latitude;
//     String longitude;
//     int busId;
//     int comingBack;
//     int status;
//     dynamic createdAt;
//     dynamic updatedAt;

//     factory Ida.fromJson(String str) => Ida.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Ida.fromMap(Map<String, dynamic> json) => Ida(
//         id: json["id"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         busId: json["bus_id"],
//         comingBack: json["coming_back"],
//         status: json["status"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toMap() => {
//         "id": id,
//         "latitude": latitude,
//         "longitude": longitude,
//         "bus_id": busId,
//         "coming_back": comingBack,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }
