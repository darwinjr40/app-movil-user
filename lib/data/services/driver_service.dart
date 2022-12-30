import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/env.dart';

class DriverService extends ChangeNotifier {
  // final String _baseUrl = "supportficct.ga/sig_backend/public/api/";

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
    debugPrint("class DriverService:getNearbyDrivers($radius/$lat/$lon)");
    List<Drivers> listaDriver = [];
    final url = baseUrl + 'drivers/nearby/$lat/$lon/$radius';
    var resp = await http.get(Uri.parse(url));
    var jsonResp = jsonDecode(resp.body);
    listaDriver = jsonResp;
    // for (var item in jsonResp) {
    //   Drivers driver = Drivers.fromMap(item);
    //   listaDriver.add(driver);
    // }
    debugPrint('LISTA CoN DRIVERS');
    debugPrint(listaDriver.length.toString());
    return listaDriver;
  }
}
