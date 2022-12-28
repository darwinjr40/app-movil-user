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
              // return SingleChildScrollView(
              //   child: Stack(
                  return Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: mapState.polylines,
                      circles: _getCircles(mapState),
                      markers: mapState.markers.values.toSet(),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          _cardGooglePlaces(),
                          Expanded(child: Container()),
                          // const CustomSearchBar(),
                          // const LegendListView(),
                        ],
                      )
                    )
                    
                  ],
                // ),
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

  Widget _cardGooglePlaces() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Desde',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                ),
              ),
              Text(
                'CRF false',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
                maxLines: 2,
              ),
              SizedBox(height: 5),
              Divider(color: Colors.grey, height: 10),
              SizedBox(height: 5),
              Text(
                'Hasta',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10
                ),
              ),
              Text(
                'NOse',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
