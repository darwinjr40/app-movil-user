part of 'bus_bloc.dart';

class BusState extends Equatable {
  final Map<String, Set<Polyline>> routes;
  final Set<Bus> buses;

  const BusState({required this.routes, required this.buses});

  // const BusState({Map<String, Set<Polyline>>? routes})
  //     : routes = routes ?? const {};

  BusState copyWith({
    Map<String, Set<Polyline>>? mapsRoutes,
     Set<Bus>? listaBuses
  }) =>BusState(
    routes: mapsRoutes ?? routes,
     buses: listaBuses ?? buses
  );

  @override
  List<Object> get props => [routes];

  @override
  String toString() => '{routes: $routes}';
}
