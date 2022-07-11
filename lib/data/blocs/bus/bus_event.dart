part of 'bus_bloc.dart';

abstract class BusEvent extends Equatable {
  const BusEvent();

  @override
  List<Object> get props => [];
}

class OnBusInitializedEvent extends BusEvent {
  final Map<String, Set<Polyline>> newRoutes;

  const OnBusInitializedEvent( this.newRoutes);
}

class OnUpdateRoutesEvent extends BusEvent {
  final Map<String, Set<Polyline>> auxRoutes;

  const OnUpdateRoutesEvent(this.auxRoutes);
}
