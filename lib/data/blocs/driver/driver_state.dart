part of 'driver_bloc.dart';

class DriverState extends Equatable {
  final bool followingDrivers;
  final List<Driver> listaDrivers;
  final Set<Polyline> polylinesDrivers;
  final bool btnDriver;
  final int busID;

  const DriverState({
    required this.listaDrivers,
    required this.polylinesDrivers,
    this.btnDriver = false,
    this.busID = -1,
    this.followingDrivers = false,
  });

  DriverState copyWith({
    List<Driver>? listaDrivers,
    Set<Polyline>? polylinesDrivers,
    bool? btnDriver,
    int? busID,
    bool? followingDrivers,
  }) =>
      DriverState(
        listaDrivers: listaDrivers ?? this.listaDrivers,
        polylinesDrivers: polylinesDrivers ?? this.polylinesDrivers,
        btnDriver: btnDriver ?? this.btnDriver,
        busID: busID ?? this.busID,
        followingDrivers: followingDrivers ?? this.followingDrivers,
      );

  @override
  List<Object?> get props => [
        listaDrivers,
        polylinesDrivers,
        btnDriver,
        busID,
        followingDrivers,
      ];
}
