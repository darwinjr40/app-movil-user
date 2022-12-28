import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/presentation/views/views.dart';
import 'package:micros_user_app/presentation/widgets/btn_show_range.dart';
import 'package:micros_user_app/presentation/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BusBloc>(context); //add
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              //   return BlocBuilder<DriverBloc, DriverState>(
              // builder: (context, driverState) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: mapState.polylines,
                      circles: _getCircles(mapState),
                      markers: mapState.markers.values.toSet(),
                    ),
                    const CustomSearchBar(),
                    const LegendListView(),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnshowBusIntersection(),
          BtnShowIntersection(),
          BtnIntersection(),
          BtnShowRange(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }

  Set<Circle> _getCircles(MapState mapState) {
    final circles = Set<Circle>.from(mapState.circles);
    if (!mapState.showMyRange) {
      circles.removeWhere((element) => element.circleId.value == 'myRange');
    }
    return circles;
  }
}
