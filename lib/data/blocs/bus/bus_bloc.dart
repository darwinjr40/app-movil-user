import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  BusBloc() : super(const BusState(routes: {})) {
    on<OnBusInitializedEvent>(
        (event, emit) => emit(state.copyWith(routes: event.routes)));
  }
}
