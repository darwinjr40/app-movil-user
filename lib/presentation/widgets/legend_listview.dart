import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LegendListView extends StatelessWidget {
  const LegendListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayLegend
            ? const _LegendListViewBody()
            : const SizedBox();
      },
    );
  }
}

class _LegendListViewBody extends StatelessWidget {
  const _LegendListViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack(),
          ),
          Positioned(
              bottom: 40,
              left: 20,
              child: SizedBox(
                width: size.width - 120,
                height: 100,
                child: FadeInUp(child: const _MapLegend()),
              )),
        ],
      ),
    );
  }
}

class _MapLegend extends StatelessWidget {
  const _MapLegend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    // final busRoutes = BusRoutes.getMapFromSet(mapBloc.state.polylines);
    final busRoutes = BlocProvider.of<BusBloc>(context)
        .getMapFromSet(mapBloc.state.polylines);
    return ListView.separated(
      reverse: true,
      itemBuilder: (context, i) => Row(
        children: [
          Icon(
            Icons.circle,
            color: busRoutes.values.elementAt(i).last.color,
            size: 15,
          ),
          const SizedBox(width: 10),
          Text('Linea ${busRoutes.keys.elementAt(i)}'),
        ],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 5),
      itemCount: busRoutes.length,
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            final Set<Polyline> emptySet = {};
            mapBloc.add(UpdatePolylinesEvent(emptySet));
            final Map<String, Marker> emptymarkers = {};
            mapBloc.add(OnUpdateMarkesEvent(emptymarkers));
            searchBloc.add(OnDeactivateLegendEvent());
          },
        ),
      ),
    );
  }
}
