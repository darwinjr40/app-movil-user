part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  final bool showMyRange;

  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Map<String, Marker> markers;

  final CameraPosition position;
  final String? from;
  final String? to;
  final LatLng? fromLatLng;
  final LatLng? toLatLng;
  final bool isFromSelected;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRange = false,
    Set<Polyline>? polylines,
    Set<Circle>? circles,
    Map<String, Marker>? markers,
    CameraPosition? position, 
    this.from,
    this.to,
    this.fromLatLng,
    this.toLatLng,
    this.isFromSelected = true,
  })  : circles = circles ?? const {},
        polylines = polylines ?? const {},
        markers = markers ?? const {},
        position = position ?? const CameraPosition(
            target: LatLng(1.2342774, -77.2645446),
            zoom: 14.0
        );

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRange,
    Set<Polyline>? polylines,
    Set<Circle>? circles,
    Map<String, Marker>? markers,
    CameraPosition? position,
    String? from,
    String? to,
    LatLng? fromLatLng,
    LatLng? toLatLng ,
    bool? isFromSelected,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRange: showMyRange ?? this.showMyRange,
        polylines: polylines ?? this.polylines,
        circles: circles ?? this.circles,
        markers: markers ?? this.markers,
        position: position ?? this.position,
        from: from ?? this.from,
        to: to ?? this.to,
        fromLatLng: fromLatLng ?? this.fromLatLng,
        toLatLng: toLatLng ?? this.toLatLng,        
        isFromSelected: isFromSelected ?? this.isFromSelected,        
      );

  @override
  List<Object?> get props => [
        isMapInitialized,
        isFollowingUser,
        showMyRange,
        polylines,
        circles,
        markers,
        position,
        from,
        to,
        fromLatLng,
        toLatLng,
        isFromSelected,   
      ];
}
