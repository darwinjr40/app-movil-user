part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

class OnStopFollowingUserMap extends MapEvent {}

class OnStartFollowingUserMap extends MapEvent {}

class OnActivateShowRange extends MapEvent {}

class OnDeactivateShowRange extends MapEvent {}

class UpdatePolylinesEvent extends MapEvent {
  final Set<Polyline> queryPolylines;

  const UpdatePolylinesEvent(this.queryPolylines);
}

class UpdateCirclesEvent extends MapEvent {
  final LatLng userlocation;

  const UpdateCirclesEvent(this.userlocation);
}

class OnUpdateMarkesEvent extends MapEvent {
  final Map<String, Marker> markersAux;

  const OnUpdateMarkesEvent(this.markersAux);
}

class OnDrawRouteMarkerEvent extends MapEvent {
  final Set<Polyline> polylines;

  const OnDrawRouteMarkerEvent({required this.polylines});
}

class UpdatePositionEvent extends MapEvent {
  final CameraPosition posicion;
  const UpdatePositionEvent({required this.posicion});
}

class UpdateFromEvent extends MapEvent {
  final String fromEvent;
  const UpdateFromEvent({required this.fromEvent});
}


class UpdateFromLatLngEvent extends MapEvent {
  final LatLng fromLngEvent;
  const UpdateFromLatLngEvent({required this.fromLngEvent});
}

class UpdateToEvent extends MapEvent {
  final String toEvent;
  const UpdateToEvent({required this.toEvent});
}

class UpdateToLatLngEvent extends MapEvent {
  final LatLng toLngEvent;
  const UpdateToLatLngEvent({required this.toLngEvent});
}

class OnChangeIsFromSelectedEvent extends MapEvent {}
