import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/delagates/delagates.dart';
import 'package:micros_user_app/data/models/models.dart';

class BtnShowIntersection extends StatelessWidget {
  const BtnShowIntersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return !state.displayLegend
            ? const SizedBox()
            : FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: const _BtnShowIntersection());
      },
    );
  }
}

class _BtnShowIntersection extends StatelessWidget {
  const _BtnShowIntersection({Key? key}) : super(key: key);

   Future onSearchResults(BuildContext context, SearResult result) async{
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    searchBloc.add(OnActivateLegendEvent());
    final polylines = result.resultPolylines;
    if (polylines!.isNotEmpty) {
      mapBloc.add(UpdatePolylinesEvent(polylines));
      await mapBloc.drawRouteMarker(polylines);
    }
  }

  @override
  Widget build(BuildContext context) {
      return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.directions_bus,
            color: Colors.black,
          ),
          
          onPressed: () async{
            final result = await showSearch(
                context: context, delegate: SearchRouteDelegate());
            if ((result == null ) || (result.cancel) || (result.resultPolylines == null)) return;
            onSearchResults(context, result);
          },
        ),
      ),
    );
  }
}