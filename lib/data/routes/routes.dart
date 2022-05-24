import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/routes/polylines/polylines.dart';

class BusRoutes {
  // * Este es el principal donde estan guardadas las rutas
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
    if (routes.containsKey(query)) {
      result.addAll({query: routes[query]!});
      return result;
    }
    routes.forEach((key, value) {
      if (key.contains(query) || query.contains(key)) {
        result.addAll({key: value});
      }
    });
    return result;
  }

  //! Aqui va ir el metodo del chispin
  //TODO: cambiar el codigo que puse en getIntersectedLines con el verdadro

  static Set<Polyline> getIntersectedLines(LatLng centro) {
    //! cambiar esto por un codigo que intersecte las rutas con un rango
    //* Ahorita lo unico que hace es devolver todas las polylines
    Set<Polyline> allRoutes = {};

    routes.forEach((key, value) {
      allRoutes.add(value.elementAt(0));
      allRoutes.add(value.elementAt(1));
    });


    //? si queres cambia los parametros, vos ves que hace falta la cosa es
    //? que este metodo tiene que de devolver el Set
    return allRoutes;
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
    for (var element in allRoutes) {
      if (idList.contains(element.mapsId.value)) {
        result.add(element);
      }
    }
    return result;
  }

  static String getKeyFromPolyline(Polyline poly) {
    String res = "";
    routes.forEach((key, value) {
      if (value.contains(poly)) {
        res = key;
      }
    });
    return res;
  }

  static Map<String, Set<Polyline>> getMapFromSet(Set<Polyline> list) {
    Map<String, Set<Polyline>> result = {};

    routes.forEach((key, value) {
      final Set<Polyline> aux = {};
      for (var element in list) {
        if (value.contains(element)) {
          aux.add(element);
        }
      }
      if (aux.isNotEmpty) {
        result.addAll({key: aux});
      }
    });
    Map<String, Set<Polyline>> reverseResult = {};
    for (int i = result.length - 1; i >= 0; i--) {
      final key = result.keys.elementAt(i);
      final value = result.values.elementAt(i);
      reverseResult.addAll({key: value});
    }
    return reverseResult;
  }
}
