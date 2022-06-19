import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/services/services.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  final BusService busService;

  BusBloc({required this.busService}) : super(const BusState(routes: {})) {
    on<OnBusInitializedEvent>(
        (event, emit) => emit(state.copyWith(routes: event.routes)));

    _init();
  }

  void _init() async {
    final varRoutes = await BusService().loadBus();
    if (varRoutes == null) {
      print('null--------------------');
      return;
    }
    // print(varRoutes);
    emit(state.copyWith(routes: varRoutes));
    // add(UpdateRoutesEvent(varRoutes));
  }

  Map<String, Set<Polyline>> searchWhereLike(String query) {
    Map<String, Set<Polyline>> routes = state.routes;
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

  // currentX currentY => coordenadas actuales del usuario
  // lineX lineY => coordenadas del micro
  // radius => constante que es radio de la circunferencia limite
  bool isInsideRadius(
      double currentX, double currentY, double lineX, double lineY) {
    const double radius = 0.002355222456223941;
    double d = sqrt(pow((lineX.abs() - currentX.abs()), 2) +
        pow((lineY.abs() - currentY.abs()), 2));
    return (d <= radius);
  }

  Set<Polyline> getIntersectedLines(Circle range) {
    Map<String, Set<Polyline>> routes = state.routes;
    print('getIntersectedLines' + routes.length.toString());
    Set<Polyline> allRoutes = {};
    routes.forEach((key, value) {
      value.elementAt(0).points.forEach((element) {
        if (isInsideRadius(range.center.longitude, range.center.latitude,
            element.longitude, element.latitude)) {
          allRoutes.add(value.elementAt(0));
        }
      });
      value.elementAt(1).points.forEach((element) {
        if (isInsideRadius(range.center.longitude, range.center.latitude,
            element.longitude, element.latitude)) {
          allRoutes.add(value.elementAt(1));
        }
      });
    });
    return allRoutes;
  }

  Set<Polyline> getAllPolylines() {
    Map<String, Set<Polyline>> routes = state.routes;
    Set<Polyline> allRoutes = {};
    routes.forEach((key, value) {
      allRoutes.add(value.elementAt(0));
      allRoutes.add(value.elementAt(1));
    });

    return allRoutes;
  }

  Set<Polyline> getPolylinesFromList(List<String> names) {
    Set<Polyline> allRoutes = {};
    Map<String, Set<Polyline>> routes = state.routes;
    routes.forEach((key, value) {
      if (names.contains(key)) {
        allRoutes.add(value.elementAt(0));
        allRoutes.add(value.elementAt(1));
      }
    });
    return allRoutes;
  }

  Set<Polyline> getEspecifiedPolylines(List<String> idList) {
    Set<Polyline> allRoutes = getAllPolylines();
    Set<Polyline> result = {};
    for (var element in allRoutes) {
      if (idList.contains(element.mapsId.value)) {
        result.add(element);
      }
    }
    return result;
  }

  String getKeyFromPolyline(Polyline poly) {
    Map<String, Set<Polyline>> routes = state.routes;
    String res = "";
    routes.forEach((key, value) {
      if (value.contains(poly)) {
        res = key;
      }
    });
    return res;
  }

  Map<String, Set<Polyline>> getMapFromSet(Set<Polyline> list) {
    Map<String, Set<Polyline>> routes = state.routes;
    Map<String, Set<Polyline>> result = {};

    state.routes.forEach((key, value) {
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
