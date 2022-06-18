part of 'bus_bloc.dart';

class BusState extends Equatable {

  final Map<String, Set<Polyline>> routes;

  const BusState({required this.routes});

  BusState copyWith({Map<String, Set<Polyline>>? routes}) =>
      BusState(routes: routes ?? this.routes);

  @override
  List<Object> get props => [routes];

  @override
  String toString() => '{routes: $routes}';
}
