import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';

class DriverService extends ChangeNotifier {

  Future<List<Drivers>> getDrivers(int busID, double lat, double lon) async {
    debugPrint("class DriverService:getDrivers($busID/$lat/$lon)");
    List<Drivers> listaDriver = [];
    final url = baseUrl + 'drivers/nearbuses/$busID/$lat/$lon';
    var resp = await http.get(Uri.parse(url));
    var jsonResp = jsonDecode(resp.body);
    
    for (var item in jsonResp) {
      Drivers driver = Drivers.fromMap(item);
      listaDriver.add(driver);
    }
    debugPrint('LISTA CoN DRIVERS');
    debugPrint(listaDriver.length.toString());
    return listaDriver;
  }

  Future<List<Drivers>> getNearbyDrivers( double lat, double lon, {double radius = 0.00785750092012667}) async {
    debugPrint("Debug class DriverService:getNearbyDrivers($radius/$lat/$lon)");
    List<Drivers> listaDriver = [];
    try {
      final url = baseUrl + 'drivers/nearby/$lat/$lon/$radius';
      var resp = await http.get(Uri.parse(url));
      var jsonResp = jsonDecode(resp.body);
      listaDriver = List<Drivers>.from(jsonResp.map((x) => Drivers.fromMap(x)));
      debugPrint('LISTA DE DRIVERS: ' + listaDriver.length.toString());
    } catch (e) {
      debugPrint('DriverService: getNearbyDrivers: ' + e.toString());
    }    
    return listaDriver;    
  }

}
