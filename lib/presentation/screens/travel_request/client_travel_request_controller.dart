import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';

class ClientTravelRequestController {

  late BuildContext context;
  late Function refresh;
  late GlobalKey<ScaffoldState> key;
  late MapBloc mapBloc;
  late DriverBloc driverBloc;
  
  late TravelInfoService _travelInfoService;
  // late DriverService _driverService;
  late StreamSubscription<List<Drivers>> _streamSubscription;

  List<String> nearbyDrivers = [];

  ClientTravelRequestController(){
    key = GlobalKey<ScaffoldState>();
    _travelInfoService = TravelInfoService();
    // _driverService = DriverService();
  }

  void init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    mapBloc = BlocProvider.of<MapBloc>(context);
    driverBloc = BlocProvider.of<DriverBloc>(context);
    _createTravelInfo();
    _getNearbyDrivers();
  }


  void dispose () {
    _streamSubscription.cancel();
  }

  void _getNearbyDrivers() {
    // Stream<List<DocumentSnapshot>> stream = _geofireProvider.getNearbyDrivers(
    //     fromLatLng.latitude,
    //     fromLatLng.longitude,
    //     5
    // );

    // _streamSubscription = stream.listen((List<DocumentSnapshot> documentList) {
    //   for (DocumentSnapshot d in documentList) {
    //     print('CONDUCTOR ENCONTRADO ${d.id}');
    //     nearbyDrivers.add(d.id);
    //   }
    // });
    final drivers = driverBloc.state.listaDrivers;
    final driversString = drivers.map((Drivers e) => e.id.toString());
    nearbyDrivers = List<String>.of(driversString);
    debugPrint(nearbyDrivers.length.toString()+ '--------------------------');
  }
  void _createTravelInfo() async {
    TravelInfo travelInfo =  TravelInfo(
      idCode: UniqueKey().toString(),
      from: mapBloc.state.from!,
      to: mapBloc.state.to!,
      fromLat: mapBloc.state.fromLatLng!.latitude,
      fromLng: mapBloc.state.fromLatLng!.longitude,
      toLat: mapBloc.state.toLatLng!.latitude,
      toLng: mapBloc.state.toLatLng!.longitude,
      status: 'created'
    );

    await _travelInfoService.create(travelInfo);
  }
}