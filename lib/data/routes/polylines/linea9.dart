import 'package:flutter/material.dart';
import '../coordenadas/rutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


final Set<Polyline> ruta9 = {
const Polyline(
polylineId: PolylineId('LN9I'),
color: Colors.pink,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta9Ida,
),

const Polyline(
polylineId: PolylineId('LN9V'),
color: Colors.pink,
width: 3,
startCap: Cap.roundCap,
endCap: Cap.roundCap,
points: ruta9Vuelta,
),

};