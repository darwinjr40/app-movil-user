import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micros_user_app/data/models/models.dart';

class DriverService extends ChangeNotifier {
  // final String _baseUrl = "supportficct.ga/sig_backend/public/api/";

  Future<List<Drivers>> getDrivers(int busID, double lat, double lon) async {
    debugPrint('entrando a la APIIIIIIIIIIIIIIIIIII');
    // var url = Uri.https(_baseUrl, '/drivers/nearbuses/1/-17.77987129557522/-63.17502205921347');
    // final resp = await http.get(url);
    var resp = await http.get(Uri.parse(
        'https://supportficct.ga/sig_backend/public/api/drivers/nearbuses/$busID/$lat/$lon'));
    var jsonResp = jsonDecode(resp.body);
    List<Drivers> listaDriver = [];

    for (var item in jsonResp) {
      Drivers driver = Drivers.fromMap(item);
      listaDriver.add(driver);
    }
    if (listaDriver.isEmpty) {
      return [];
    }
    debugPrint('LISTA CoN DRIVERS');
    debugPrint(listaDriver.length.toString());
    return listaDriver;
  }
}
