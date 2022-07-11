part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayLegend;
  final Map<String, Set<Polyline>> routes;

  const SearchState({
    this.displayLegend = false,
    Map<String, Set<Polyline>>? routesVar,
  }) : routes = routesVar ?? const {};

  SearchState copyWith({
    bool? displayLegend,
    Map<String, Set<Polyline>>? routes,
  }) =>
      SearchState(
        displayLegend: displayLegend ?? this.displayLegend,
        routesVar: routes ?? this.routes,
      );

  @override
  List<Object> get props => [displayLegend, routes];
}
