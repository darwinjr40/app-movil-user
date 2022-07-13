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
  }
  void _onGetDriver(OnGetDriverEvent event, Emitter<DriverState> emit) async {
    final List<Drivers> newListDrivers =
        await driverService.getDrivers(1, 1, 1);
    debugPrint(newListDrivers.length.toString());
    emit(state.copyWith(listaDrivers: newListDrivers));
    await Future.delayed(const Duration(milliseconds: 300));
    Set<Polyline> newPolylinesDrivers = {};
    LatLng newLatLng;

    debugPrint('Darwin---------------------------------');
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
    debugPrint('Darwin---------------------------------');
    debugPrint('Darwin---------------------------------');
    debugPrint('Darwin---------------------------------');
    debugPrint('Darwin---------------------------------');
    debugPrint('Darwin---------------------------------');
    debugPrint('Darwin---------------------------------');
    emit(state.copyWith(polylinesDrivers: newPolylinesDrivers));
  }
}
