import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<Marker> markers;

  //constructor
  const MapView({
    Key? key,
    required this.initialLocation,
    required this.polylines,
    required this.circles,
    required this.markers,
  }) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15,
    );
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) =>
            mapBloc.add(OnStopFollowingUserMap()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          markers: markers,
          circles: circles,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
        ),
      ),
    );
  }
}
