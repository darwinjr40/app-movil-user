part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  final bool showMyRange;

  final Set<Polyline> polylines;
  final Set<Circle> circles;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRange = false,
    Set<Polyline>? polylines,
    Set<Circle>? circles,
  })  : circles = circles ?? const {},
        polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRange,
    Set<Polyline>? polylines,
    Set<Circle>? circles,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRange: showMyRange ?? this.showMyRange,
        polylines: polylines ?? this.polylines,
        circles: circles ?? this.circles,
      );

  @override
  List<Object> get props => [
        isMapInitialized,
        isFollowingUser,
        showMyRange,
        polylines,
        circles,
      ];
}
