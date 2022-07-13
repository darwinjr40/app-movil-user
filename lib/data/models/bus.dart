import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Data {
  Data({
    required this.bus,
    required this.paths,
  });

  Bus bus;
  Path paths;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bus: Bus.fromMap(json["bus"]),
        paths: Path.fromMap(json["paths"]),
      );


}

class Bus {
  Bus({
    required this.id,
    required this.color,
    required this.name,
    required this.photo,
    required this.status,
  });

  int id;
  String color;
  String name;
  String photo;
  int status;

  factory Bus.fromJson(String str) => Bus.fromMap(json.decode(str));

  factory Bus.fromMap(Map<String, dynamic> json) => Bus(
        id: json["id"],
        color: json["color"],
        name: json["name"],
        photo: json["photo"],
        status: json["status"],
      );

}

class Path {
  Path({
    required this.ida,
    required this.vuelta,
  });

  List<LatLng> ida;
  List<LatLng> vuelta;

  factory Path.fromJson(String str) => Path.fromMap(json.decode(str));


  factory Path.fromMap(Map<String, dynamic> json) => Path(
        ida: List<LatLng>.from(json["ida"].map((x) => LatLng(
            double.parse((x)["latitude"]), double.parse((x)["longitude"])))),
        vuelta: List<LatLng>.from(json["vuelta"].map((x) => LatLng(
            double.parse((x)["latitude"]), double.parse((x)["longitude"])))),
      );
  // factory Path.fromMap(Map<String, dynamic> json) => Path(
  //     ida: List<LatLng>.from(json["ida"].map((x) => LatLng.fromMap(x))),
  //     vuelta: List<LatLng>.from(json["vuelta"].map((x) => LatLng.fromMap(x))),
  // );

  // Map<String, dynamic> toMap() => {
  //     "ida": List<dynamic>.from(ida.map((x) => x.toMap())),
  //     "vuelta": List<dynamic>.from(vuelta.map((x) => x.toMap())),
  // };
}

