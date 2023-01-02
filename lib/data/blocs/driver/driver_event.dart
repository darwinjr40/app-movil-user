part of 'driver_bloc.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

class OnGetDriverEvent extends DriverEvent {
  final int busId;
  final double latitud;
  final double longitud;
  const OnGetDriverEvent({
    required this.busId,
    required this.latitud,
    required this.longitud,
  });
}

class OnPolylineEvent extends DriverEvent {}

class OnBtnDriverEvent extends DriverEvent {
  final bool boton;
  const OnBtnDriverEvent({required this.boton});
}

class OnBusIDEvent extends DriverEvent {
  final int busID;
  const OnBusIDEvent({required this.busID});
}

class OnStartFollowingDriversEvent extends DriverEvent {}

class OnUpdateListaDriversEvent extends DriverEvent {
  final List<Driver> driversAux;
  const OnUpdateListaDriversEvent({required this.driversAux});
}
