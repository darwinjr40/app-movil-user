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
    List<Color> colorLineas = [
      Colors.red.withOpacity(0.7), Colors.red, //1
      Colors.blue.withOpacity(0.7), Colors.blue, //2
      Colors.green.withOpacity(0.7), Colors.green, //5
      Colors.deepPurple.withOpacity(0.7), Colors.deepPurple, //8
      Colors.pink.withOpacity(0.7), Colors.pink, //9
      Colors.brown.withOpacity(0.7), Colors.brown, //10
      Colors.teal.withOpacity(0.7), Colors.teal, //11
      Colors.indigo.withOpacity(0.7), Colors.indigo, //16
      Colors.orange.withOpacity(0.7), Colors.orange, //17
      Colors.yellowAccent.withOpacity(0.7), Colors.yellowAccent, //18
    ];
    int i = 0;
    for (var item in decodedResp) {
      //recorre todos los buses
      linea = {};
      List<LatLng> rutaIda = [];
      List<LatLng> rutaVuelta = [];
      String a = item["bus"]["id"].toString();
      for (var ida in item["paths"]["ida"]) {
        rutaIda.add(LatLng(
            double.parse(ida["latitude"]), double.parse(ida["longitude"])));
      }
      lineaRutaIda = Polyline(
          polylineId: PolylineId('ln' + a + 'Ida'),
          // color: Colors.red.withOpacity(0.7),
          color: colorLineas[i],
          width: 3,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: rutaIda,
          patterns: [
            PatternItem.dash(30.0),
            PatternItem.gap(20.0),
            // PatternItem.dot,
            // PatternItem.gap(20.0),
          ],
          consumeTapEvents: true,
          onTap: () {
            debugPrint('------------------------------Ruta de ida');
          });

      i++;
      for (var vuelta in item["paths"]["vuelta"]) {
        rutaVuelta.add(LatLng(double.parse((vuelta["latitude"])),
            double.parse(vuelta["longitude"])));
      }
      lineaRutaVuelta = Polyline(
        polylineId: PolylineId('ln' + a + 'Vuelta'),
        // color: Colors.red,
        color: colorLineas[i],
        width: 3,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: rutaVuelta,
      );
      i++;
      linea.add(lineaRutaIda);
      linea.add(lineaRutaVuelta);
      // print(a);
      routes.addAll({a: linea});
    }

    // print(routes);
    // print("arriba----------------------------------------------");
    return routes;
  }
}
