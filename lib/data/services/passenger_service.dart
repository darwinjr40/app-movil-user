// To parse this JSON data, do
//
//     final passenger = passengerFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:micros_user_app/env.dart';
import 'package:http/http.dart' as http;


class PassengerService {

  static Future<void> create(Map<String, dynamic> data) async {
    try {
      // return _ref.doc(travelInfo.id).set(travelInfo.toJson());
      debugPrint(data.toString());
      const url = '${baseUrl}passenger/store';
      final resp = await http.post(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: data,
      );
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode != 200) {
        debugPrint(resp.body);
      }            
    } catch(error) {
      debugPrint(error.toString());
      return Future.error(error.toString());
    }    
  }

   
}
