import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataInfo {
  String text;
  int value;

  DataInfo({
    required this.text,
    required this.value
  });

  factory DataInfo.fromMap(Map<String, dynamic> json) => DataInfo(
    text: json['text'],
    value: json['value'],
  );
}

class Direction {

  DataInfo distance;
  DataInfo duration;
  String startAddress;
  String endAddress;
  LatLng startLocation;
  LatLng endLocation;

  Direction({
    required this.distance,
    required this.duration,
    required this.startAddress,
    required this.endAddress,
    required this.startLocation,
    required this.endLocation
  });

  factory Direction.fromMap(Map<String, dynamic> json) => Direction(
    distance      :  DataInfo.fromMap(json['distance']),
    duration      :  DataInfo.fromMap(json['duration']),
    startAddress  : json['start_address'],
    endAddress    : json['end_address'],
    startLocation :  LatLng(json['start_location']['lat'], json['start_location']['lng']),
    endLocation   :  LatLng(json['end_location']['lat'], json['end_location']['lng']),
  );

  Map<String, dynamic> toJson() => {
    'distance': distance,
    'duration': duration,
  };
  // Map<String, dynamic> toJson() => {
  //   'distance': distance == null ? '' : distance!.text,
  //   'duration': duration == null ? '' : distance!.text,
  // };

}