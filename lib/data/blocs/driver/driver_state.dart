part of 'driver_bloc.dart';

class DriverState extends Equatable {
  final List<Drivers>? listaDrivers;

  const DriverState({this.listaDrivers});

  DriverState copyWith({
    List<Drivers>? listaDrivers,
  }) => DriverState(
    listaDrivers: listaDrivers ?? listaDrivers,
  );

  @override
  List<Object?> get props => [
    listaDrivers,
  ];
}
