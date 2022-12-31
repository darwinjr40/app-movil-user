// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/presentation/views/views.dart';
import 'package:micros_user_app/presentation/widgets/widgets.dart';
import 'package:micros_user_app/presentation/utils/utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late DriverBloc driverBloc;


  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    BlocProvider.of<BusBloc>(context); //add
    driverBloc = BlocProvider.of<DriverBloc>(context);
    
    // driverBloc
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();  
    driverBloc.startFollowingDrivers(mapBloc, driverBloc, locationBloc);
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
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
                      _cardGooglePlaces(mapState),
                      _buttonChangeTo(mapBloc),
                      Expanded(child: Container()),
                      _buttonRequest(),
                      // const CustomSearchBar(),
                      // const LegendListView(),
                    ],
                  )),
                  Align(
                    alignment: Alignment.center,
                    child: _iconMyLocation(),
                  ),
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
          // BtnshowBusIntersection(),
          // BtnShowIntersection(),
          // BtnIntersection(),
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

  Widget _cardGooglePlaces(MapState mapState) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Desde',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                mapState.from ?? '...',
                // 'CRF false',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.grey, height: 10),
              const SizedBox(height: 5),
              const Text(
                'Hasta',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                mapState.to ?? '...',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/my_location.png',
      // 'assets/bus3.png',
      width: 25,
      height: 25,
    );
  }

  Widget _buttonRequest() {
    return Container(
      height: 50,
      width: 200,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: BtnSolicit(
        onPressed: requestDriver,
        text: 'SOLICITAR',
        color: Colors.amber,
        textColor: Colors.black,
      ),
    );
  }

  void requestDriver() {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    if (mapBloc.state.toLatLng == null || mapBloc.state.fromLatLng == null) {
      Snackbar.showSnackbar(context, 'Seleccionar el lugar de recogida y destino');
    } else {
      Navigator.pushNamed(context, 'client/travel/info');
    }
  }

  Widget _buttonChangeTo(MapBloc mapBloc) {
    return GestureDetector(
      onTap: _changeFromTo,
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.refresh,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _changeFromTo()async {
    final String message;
    mapBloc.add(OnChangeIsFromSelectedEvent());
    await Future.delayed(const Duration(milliseconds: 300));    
    if (mapBloc.state.isFromSelected) {
      message = 'SELECCIONA EL ORIGEN';
    } else {
      message = 'SELECCIONA EL DESTINO';
    }
    Snackbar.showSnackbar(context, message);
  }
}
