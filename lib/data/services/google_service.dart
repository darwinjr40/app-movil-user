import 'dart:convert';
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/env.dart';
import 'package:micros_user_app/data/models/models.dart';

class GoogleService {
  
  Future<dynamic> getGoogleMapsDirections (double fromLat, double fromLng, double toLat, double toLng) async {
    print('SE ESTA EJECUTANDO');

    Uri uri = Uri.https(
        'maps.googleapis.com',
        'maps/api/directions/json', {
          'key': googleApiKey,
          'origin': '$fromLat,$fromLng',
          'destination': '$toLat,$toLng',
          'traffic_model' : 'best_guess',
          'departure_time': DateTime.now().microsecondsSinceEpoch.toString(),
          'mode': 'driving',
          'transit_routing_preferences': 'less_driving'
        }
    );
    print('URL: $uri');
    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    final leg =  Direction.fromMap(decodedData['routes'][0]['legs'][0]);
    return leg;
  }


  Future<dynamic> getGeoInv (double lat, double lng) async {
    print('getGeoInv----------------------');
    try {
      String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAvUexPfr0cJLlaF08zCb1X3aggukbaIAI';
      final response = await http.get(Uri.parse(url));
      final decodedData = json.decode(response.body);
      print(decodedData);
      return decodedData;
      
    } catch (e) {
      debugPrint('error getGeoInv ----------------------');
      return "error getGeoInv ----------------------";
    }
  }
}