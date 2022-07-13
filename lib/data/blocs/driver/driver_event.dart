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
