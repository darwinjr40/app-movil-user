import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


final Set<Polyline> ruta8 = {
const Polyline(
polylineId: PolylineId('LN8I'),
color: Colors.deepPurple,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta8Ida,
),

const Polyline(
polylineId: PolylineId('LN8V'),
color: Colors.deepPurple,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta8Vuelta,
),

};