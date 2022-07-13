import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/services/services.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverService driverService;

  DriverBloc({required this.driverService}) : super(const DriverState()) {
    on<DriverEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnGetDriverEvent>(_onGetDriver);
  }
  void _onGetDriver(OnGetDriverEvent event, Emitter<DriverState> emit) async {
    debugPrint("ENTRA AL BLOC GET DRIVER");
    final List<Drivers> newListDrivers =
        await driverService.getDrivers(1, 1, 1);
    debugPrint(newListDrivers.length.toString());
    debugPrint("COMPLETADO EL BLOC GET DRIVER");
    emit(state.copyWith(listaDrivers: newListDrivers));
  }
}
