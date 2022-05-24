part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayLegend;

  const SearchState({
    this.displayLegend = false,
  });

  SearchState copyWith({
    bool? displayLegend,
  }) =>
      SearchState(
        displayLegend: displayLegend ?? this.displayLegend,
      );

  @override
  List<Object> get props => [displayLegend];
}
