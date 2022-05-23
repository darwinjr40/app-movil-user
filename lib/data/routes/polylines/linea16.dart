import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Polyline> ruta16 = {
  const Polyline(
    polylineId: PolylineId('LN16I'),
    color: Colors.yellow,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta16Ida,
  ),
  const Polyline(
    polylineId: PolylineId('LN16V'),
    color: Colors.yellow,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta16Vuelta,
  ),
};
