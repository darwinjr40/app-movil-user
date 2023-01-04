import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';

class DriverService extends ChangeNotifier {

  Future<List<Driver>> getDrivers(int busID, double lat, double lon) async {
    debugPrint("class DriverService:getDrivers($busID/$lat/$lon)");
    List<Driver> listaDriver = [];
    final url = '${baseUrl}drivers/nearbuses/$busID/$lat/$lon';
    var resp = await http.get(Uri.parse(url));
    var jsonResp = jsonDecode(resp.body);
    
    for (var item in jsonResp) {
      Driver driver = Driver.fromMap(item);
      listaDriver.add(driver);
    }
    debugPrint('LISTA CoN DRIVERS');
    debugPrint(listaDriver.length.toString());
    return listaDriver;
  }

  Future<List<Driver>> getNearbyDrivers( double lat, double lon, {double radius = 0.00785750092012667}) async {
    debugPrint("Debug class DriverService:getNearbyDrivers($radius/$lat/$lon)");
    List<Driver> listaDriver = [];
    try {
      final url = '${baseUrl}drivers/nearby/$lat/$lon/$radius';
      var resp = await http.get(Uri.parse(url));
      var jsonResp = jsonDecode(resp.body);
      listaDriver = List<Driver>.from(jsonResp.map((x) => Driver.fromMap(x)));
      debugPrint('LISTA DE DRIVERS: ${listaDriver.length}');
    } catch (e) {
      debugPrint('DriverService: getNearbyDrivers: $e');
    }    
    return listaDriver;    
  }


  static Future<Driver?> getbyId(String idDriver) async {
    Driver? driver;
    try {
      final url = '${baseUrl}drivers/getById/$idDriver';
      final resp = await http.get(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
      );
      if (resp.statusCode == 200) {
        driver = Driver.fromJson(resp.body);
      } else {
        debugPrint('ERROR <DriverService>getbyId: ${resp.body}');
      }           
    } catch(error) {
      debugPrint('ERROR TRY CATCH <DriverService>getbyId: ${error.toString()}');
    }    
      return driver;
  }

}
