import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/services/services.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  
  final BusService busService;
  
  BusBloc({required this.busService}) : super(const BusState(routes: {})) {
    on<OnBusInitializedEvent>(
        (event, emit) => emit(state.copyWith(routes: event.routes)));

    _init();
  }

  void _init() async {
    final varRoutes = await BusService().loadBus();
    if (varRoutes == null) {
      print('null--------------------');
      return;
    }
    print(varRoutes);
    emit(state.copyWith(routes: varRoutes));
    // add(UpdateRoutesEvent(varRoutes));
  }
}
