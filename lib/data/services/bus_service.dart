import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusService {
  final String _baseUrl = 'https://supportficct.ga/sig_backend/api/';

  Future<Map<String, Set<Polyline>>?> loadBus() async {
    final url = (_baseUrl + 'bus/all');
    final resp = await http.get(Uri.parse(url));
    var decodedResp = json.decode(resp.body);
    Map<String, Set<Polyline>> routes;
    Polyline lineaRutaIda;
    Polyline lineaRutaVuelta;
    Set<Polyline> linea;
    routes = {};
    for (var item in decodedResp) {
      //recorre todos los buses
      linea = {};
      List<LatLng> rutaIda = [];
      List<LatLng> rutaVuelta = [];
      for (var ida in item["paths"]["ida"]) {
        rutaIda.add(LatLng(
            double.parse(ida["latitude"]), double.parse(ida["longitude"])));
      }
      lineaRutaIda = Polyline(
        polylineId: const PolylineId('lnIda'),
        color: Colors.red.withOpacity(0.7),
        width: 3,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: rutaIda,
      );

      for (var vuelta in item["paths"]["vuelta"]) {
        rutaVuelta.add(LatLng(double.parse((vuelta["latitude"])),
            double.parse(vuelta["longitude"])));
      }
      lineaRutaVuelta = Polyline(
        polylineId: const PolylineId('lnVuelta'),
        color: Colors.red,
        width: 3,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: rutaVuelta,
      );
      linea.add(lineaRutaIda);
      linea.add(lineaRutaVuelta);
      String a = item["bus"]["id"].toString();
      // print(a);
      routes.addAll({a: linea});
    }
    // print(routes);
    print("arriba----------------------------------------------");
    return routes;
  }
}
