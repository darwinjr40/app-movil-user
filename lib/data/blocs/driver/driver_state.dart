part of 'driver_bloc.dart';

class DriverState extends Equatable {
  final List<Drivers> listaDrivers;
  final Set<Polyline> polylinesDrivers;

  const DriverState({required this.listaDrivers, required this.polylinesDrivers });

  DriverState copyWith({
    List<Drivers>? listaDrivers,
    Set<Polyline>? polylinesDrivers,
  }) => DriverState(
    listaDrivers: listaDrivers ?? this.listaDrivers,
    polylinesDrivers: polylinesDrivers ?? this.polylinesDrivers,
  );

  @override
  List<Object?> get props => [
    listaDrivers,
    polylinesDrivers,
  ];
}
