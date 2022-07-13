part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateLegendEvent extends SearchEvent {}

class OnDeactivateLegendEvent extends SearchEvent {}

class OnUpdateRoutesSearchEvent extends SearchEvent {
  final Map<String, Set<Polyline>> auxRoutes;

  const OnUpdateRoutesSearchEvent(this.auxRoutes);
}
