import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';
import 'package:http/http.dart' as http;

class TravelInfoService {

  // CollectionReference _ref;

  // TravelInfoProvider() {
    // _ref = FirebaseFirestore.instance.collection('TravelInfo');
  // }

  Future<void> create(TravelInfo travelInfo) async {
    try {
      // return _ref.doc(travelInfo.id).set(travelInfo.toJson());
      debugPrint(travelInfo.toMap().toString());
      const url = baseUrl + 'travel-info';
      final resp = await http.post(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: travelInfo.toMap(),
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