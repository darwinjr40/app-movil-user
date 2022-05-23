import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/routes/polylines/polylines.dart';

class BusRoutes {
  static final Map<String, Set<Polyline>> routes = {
    '1': ruta1,
    '2': ruta2,
    '5': ruta5,
    '8': ruta8,
    '9': ruta9,
    '10': ruta10,
    '11': ruta11,
    '16': ruta16,
    '17': ruta17,
    '18': ruta18,
  };

  static Map<String, Set<Polyline>> searchWhereLike(String query) {
    Map<String, Set<Polyline>> result = {};
    routes.forEach((key, value) {
      if (key.contains(query)) {
        result.addAll({key: value});
      }
    });
    return result;
  }

  static Set<Polyline> getAllPolylines() {
    Set<Polyline> allRoutes = {};

    routes.forEach((key, value) {
      allRoutes.add(value.elementAt(0));
      allRoutes.add(value.elementAt(1));
    });

    return allRoutes;
  }

  static Set<Polyline> getPolylinesFromList(List<String> names) {
    Set<Polyline> allRoutes = {};

    routes.forEach((key, value) {
      if (names.contains(key)) {
        allRoutes.add(value.elementAt(0));
        allRoutes.add(value.elementAt(1));
      }
    });

    return allRoutes;
  }

  static Set<Polyline> getEspecifiedPolylines(List<String> idList) {
    Set<Polyline> allRoutes = getAllPolylines();
    Set<Polyline> result = {};
    allRoutes.forEach((element) {
      if (idList.contains(element.mapsId.value)) {
        result.add(element);
      }
    });
    return result;
  }
}
