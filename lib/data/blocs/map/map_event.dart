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
