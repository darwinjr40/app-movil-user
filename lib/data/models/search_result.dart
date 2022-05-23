import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearResult {
  final bool cancel;
  final Set<Polyline>? resultPolylines;

  SearResult({
    required this.cancel,
    this.resultPolylines,
  });

  @override
  String toString() {
    return '{ cancel: $cancel, polylines: ${resultPolylines != null}}';
  }
}
