part of 'driver_bloc.dart';

class DriverState extends Equatable {
  final List<Drivers> listaDrivers;
  final Set<Polyline> polylinesDrivers;
  final bool btnDriver;
  final int busID;

  const DriverState({
    required this.listaDrivers,
    required this.polylinesDrivers,
    this.btnDriver = false,
    this.busID = -1,
  });

  DriverState copyWith({
    List<Drivers>? listaDrivers,
    Set<Polyline>? polylinesDrivers,
    bool? btnDriver,
    int? busID,
  }) =>
      DriverState(
        listaDrivers: listaDrivers ?? this.listaDrivers,
        polylinesDrivers: polylinesDrivers ?? this.polylinesDrivers,
        btnDriver: btnDriver ?? this.btnDriver,
        busID: busID ?? this.busID,
      );

  @override
  List<Object?> get props => [
        listaDrivers,
        polylinesDrivers,
        btnDriver,
        busID,
      ];
}
