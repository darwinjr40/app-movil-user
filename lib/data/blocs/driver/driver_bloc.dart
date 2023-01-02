import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/location/location_bloc.dart';
import 'package:micros_user_app/data/blocs/map/map_bloc.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverService driverService;
  StreamSubscription<List<int>>? driverStream;
  StreamSubscription<Position>? positionStream;


  DriverBloc({required this.driverService})
      : super(const DriverState(listaDrivers: [], polylinesDrivers: {})) {
    on<DriverEvent>((event, emit) {
      // ignore: todo
      // TODO: implement event handler
    });

    on<OnGetDriverEvent>(_onGetDriver);

    on<OnBtnDriverEvent>(
        (event, emit) => emit(state.copyWith(btnDriver: event.boton)));

    on<OnBusIDEvent>((event, emit) => emit(state.copyWith(busID: event.busID)));
    
    on<OnStartFollowingDriversEvent>((event, emit) => emit(state.copyWith(followingDrivers: true)));
    
    on<OnUpdateListaDriversEvent>((event, emit) => emit(state.copyWith(listaDrivers: event.driversAux)));
  }
  void _onGetDriver(OnGetDriverEvent event, Emitter<DriverState> emit) async {
    debugPrint('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    debugPrint(state.busID.toString());
    Set<Polyline> newPolylinesDrivers = {};
    LatLng newLatLng;
    List<Driver> newListDrivers = await driverService.getDrivers(state.busID, event.latitud, event.longitud);
    debugPrint(newListDrivers.length.toString());

    emit(state.copyWith(listaDrivers: newListDrivers));
    await Future.delayed(const Duration(milliseconds: 300));    
    debugPrint(state.listaDrivers.length.toString());
    for (var driver in newListDrivers) {
      newLatLng = LatLng(driver.currentLat, driver.currentLong);
      newPolylinesDrivers.add(
        Polyline(
          polylineId: PolylineId('${driver.id}'),
          points: [newLatLng],
        ),
      );
    }
    emit(state.copyWith(polylinesDrivers: newPolylinesDrivers));
  }


  void startFollowingDrivers(MapBloc mapBloc, DriverBloc driverBloc, LocationBloc locationBloc) async {
    LatLng? location;
    List<Driver> drivers;
    Iterable<Polyline> polylines;
    Set<Polyline> polylinesDrivers;
    add(OnStartFollowingDriversEvent());    
    positionStream = Geolocator.getPositionStream().listen((event) async{      
      location = locationBloc.state.lastKnownLocation;
      if (location != null) {
        drivers = await driverService.getNearbyDrivers(location!.latitude, location!.longitude);
        if (drivers.isEmpty) {
          polylinesDrivers = {};
        } else {
          polylines = drivers.map((Driver e) => _getPolyline(e));
          polylinesDrivers = Set<Polyline>.from( polylines.toSet());
        }
        driverBloc.add(OnUpdateListaDriversEvent(driversAux: drivers));
        mapBloc.add(OnDrawRouteMarkerEvent(polylines: polylinesDrivers));
      }
    });
  }

  Polyline _getPolyline(Driver d)=> Polyline(
    polylineId: PolylineId('${d.id}'),
    points: [LatLng(d.currentLat, d.currentLong)],
  );
  
}
