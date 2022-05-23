import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/routes/polylines/polylines.dart';

class BusRoutes {
  static final Map<String, Set<Polyline>> _routes = {
    '1': ruta1,
    '2': ruta2,
    '5': ruta5,
    '8': ruta8,
    '10': ruta10,
  };

  static Set<Polyline> getAllPolylines() {
    Set<Polyline> allRoutes = {};

    _routes.forEach((key, value) {
      allRoutes.add(value.elementAt(0));
      allRoutes.add(value.elementAt(1));
    });

    return allRoutes;
  }

  static Set<Polyline> getPolylinesByBus(String name) {
    return _routes[name]!;
  }

  static Set<Polyline> getPolylinesFromList(List<String> names) {
    Set<Polyline> allRoutes = {};

    _routes.forEach((key, value) {
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
