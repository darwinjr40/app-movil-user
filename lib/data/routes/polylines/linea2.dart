import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Polyline> ruta2 = {
  const Polyline(
    polylineId: PolylineId('LN2I'),
    color: Colors.blue,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta2Ida,
  ),
  const Polyline(
    polylineId: PolylineId('LN2V'),
    color: Colors.blue,
    width: 3,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: ruta2Vuelta,
  ),
};
