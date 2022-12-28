import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverService driverService;

  DriverBloc({required this.driverService})
      : super(const DriverState(listaDrivers: [], polylinesDrivers: {})) {
    on<DriverEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnGetDriverEvent>(_onGetDriver);

    on<OnBtnDriverEvent>(
        (event, emit) => emit(state.copyWith(btnDriver: event.boton)));

    on<OnBusIDEvent>((event, emit) => emit(state.copyWith(busID: event.busID)));
  }
  void _onGetDriver(OnGetDriverEvent event, Emitter<DriverState> emit) async {
    debugPrint('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    debugPrint(state.busID.toString());
    Set<Polyline> newPolylinesDrivers = {};
    LatLng newLatLng;
    List<Drivers> newListDrivers = await driverService.getDrivers(state.busID, event.latitud, event.longitud);
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
}
