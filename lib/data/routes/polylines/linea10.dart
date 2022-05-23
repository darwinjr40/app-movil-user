import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


final Set<Polyline> ruta10 = {
const Polyline(
polylineId: PolylineId('LN10I'),
color: Colors.cyan,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta10Ida,
),

const Polyline(
polylineId: PolylineId('LN10V'),
color: Colors.cyan,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta10Vuelta,
),

};