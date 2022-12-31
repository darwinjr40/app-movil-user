import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

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
          onCameraMove: (position)  {
            mapBloc.add(UpdatePositionEvent(posicion: position));
          },
          onCameraIdle: () async{
            await setLocationDraggableInfo(mapBloc);
          },
        ),
      ),
    );
  }


  Future<void> setLocationDraggableInfo(MapBloc mapBloc) async {
    final pos = mapBloc.state.position;
      double lat = pos.target.latitude;
      double lng = pos.target.longitude;
      try {
        List<Placemark> address = await placemarkFromCoordinates(lat, lng);

        if (address.isNotEmpty) {
            String direction = address[0].thoroughfare!;
            String street = address[0].subThoroughfare!;
            String city = address[0].locality!;
            String department = address[0].administrativeArea!;
            // String country = address[0].country!;

            if (mapBloc.state.isFromSelected) {
              final from = '$direction #$street, $city, $department';
              final fromLatLng = LatLng(lat, lng);
              mapBloc.add(UpdateFromEvent(fromEvent: from));
              mapBloc.add(UpdateFromLatLngEvent(fromLngEvent: fromLatLng));
            } else {
              final to = '$direction #$street, $city, $department';
              final toLatLng = LatLng(lat, lng);
              mapBloc.add(UpdateToEvent(toEvent: to));
              mapBloc.add(UpdateToLatLngEvent(toLngEvent: toLatLng));
            }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      
  }
  
  
}
