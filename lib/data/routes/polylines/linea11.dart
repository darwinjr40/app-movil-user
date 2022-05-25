import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Polyline> ruta11 = {
  Polyline(
    polylineId: const PolylineId('LN11I'),
    color: Colors.teal.withOpacity(0.7),
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta11Ida,
  ),
  const Polyline(
    polylineId: PolylineId('LN11V'),
    color: Colors.teal,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta11Vuelta,
  ),
};
