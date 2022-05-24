import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/presentation/themes/themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserMap>(_onStartFollowingUser);
    on<OnStopFollowingUserMap>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));

    on<UpdatePolylinesEvent>(
        (event, emit) => emit(state.copyWith(polylines: event.queryPolylines)));

    on<OnActivateShowRange>(
        (event, emit) => emit(state.copyWith(showMyRange: true)));

    on<OnDeactivateShowRange>(
        (event, emit) => emit(state.copyWith(showMyRange: false)));

    on<UpdateCirclesEvent>(_onCircleUpdate);

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateCirclesEvent(locationState.lastKnownLocation!));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserMap event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;

    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onCircleUpdate(UpdateCirclesEvent event, Emitter<MapState> emit) {
    final myRange = Circle(
      circleId: const CircleId('myRange'),
      center: event.userlocation,
      radius: 250,
      fillColor: const Color.fromARGB(118, 50, 147, 225),
      strokeColor: Colors.blue,
      strokeWidth: 3,
    );

    

    final myCircles = {myRange};

    emit(state.copyWith(circles: myCircles));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
