import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<OnActivateLegendEvent>(
        (event, emit) => emit(state.copyWith(displayLegend: true)));
    on<OnDeactivateLegendEvent>(
        (event, emit) => emit(state.copyWith(displayLegend: false)));
  }
}
