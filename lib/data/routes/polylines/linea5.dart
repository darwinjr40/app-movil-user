import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Polyline> ruta5 = {
  Polyline(
    polylineId: const PolylineId('LN5I'),
    color: Colors.green.withOpacity(0.7),
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta5Ida,
  ),
  const Polyline(
    polylineId: PolylineId('LN5V'),
    color: Colors.green,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta5Vuelta,
  ),
};
