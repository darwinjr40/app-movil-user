part of 'bus_bloc.dart';

abstract class BusEvent extends Equatable {
  const BusEvent();

  @override
  List<Object> get props => [];
}

class OnBusInitializedEvent extends BusEvent{
  final Map<String, Set<Polyline>> routes;

  const OnBusInitializedEvent({ required this.routes}); 
}
