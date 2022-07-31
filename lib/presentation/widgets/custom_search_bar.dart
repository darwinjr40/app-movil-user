import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/delagates/delagates.dart';
import 'package:micros_user_app/data/models/models.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      return BlocBuilder<DriverBloc, DriverState>(
          builder: (context, driverState) {
        return searchState.displayLegend
            ? const SizedBox()
            : FadeInDown(
                duration: const Duration(milliseconds: 300),
                child: const _CustomSearchBarBody(),
              );
      });
    });
  }
}

class _CustomSearchBarBody extends StatelessWidget {
  const _CustomSearchBarBody({Key? key}) : super(key: key);

  Future onSearchResults(BuildContext context, SearResult result) async {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final polylines = result.resultPolylines;
    if (polylines!.isNotEmpty) {
      mapBloc.add(UpdatePolylinesEvent(polylines));
      final lineasUnicas =
          BlocProvider.of<BusBloc>(context).getMapFromSet(polylines);
      final driverBloc = BlocProvider.of<DriverBloc>(context);
      driverBloc.add(OnBusIDEvent(busID: int.parse(lineasUnicas.keys.first)));
      driverBloc.add(const OnBtnDriverEvent(boton: true));
      debugPrint(driverBloc.state.btnDriver.toString() + "search");
      debugPrint(driverBloc.state.busID.toString());
      searchBloc.add(OnUpdateRoutesSearchEvent(lineasUnicas));
      searchBloc.add(OnActivateLegendEvent());
      // await mapBloc.drawRouteMarker(polylines);
    }
  }

  @override
  Widget build(BuildContext context) {
    final driverBloc = BlocProvider.of<DriverBloc>(context);
    return BlocBuilder<DriverBloc, DriverState>(
        builder: (context, driverState) {
      return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SearchRouteDelegate());
              // driverBloc.add(const OnBtnDriverEvent(boton: true));
              // debugPrint(driverState.btnDriver.toString());
              if ((result == null) ||
                  (result.cancel) ||
                  (result.resultPolylines == null)) return;

              onSearchResults(context, result);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              child: const Text(
                'Elegir una Linea de Micro',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
