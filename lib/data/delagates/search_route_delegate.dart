import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/polyline.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';
import 'package:micros_user_app/data/routes/routes.dart';

class SearchRouteDelegate extends SearchDelegate<SearResult> {
  SearchRouteDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
          keyboardType: TextInputType.number,
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = BusRoutes.searchWhereLike(query);
    return result.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, i) => ListTile(
              title: Text(
                'Linea ${result.keys.elementAt(i)}',
                style: const TextStyle(color: Colors.black),
              ),
              leading: const FaIcon(
                FontAwesomeIcons.bus,
                color: Colors.black,
              ),
              onTap: () {
                final res = SearResult(
                  cancel: false,
                  resultPolylines: result.values.elementAt(i),
                );
                close(context, res);
              },
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: result.length,
          )
        : const Center(
            child: Text(
              'No se encontraron resultados, intenta con otro numero',
              style: TextStyle(color: Colors.black87),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final busRoutes = BlocProvider.of<BusBloc>(context).state.routes;
    //  final busRoutes = BusRoutes.routes;
    // return BlocBuilder<BusBloc, BusState>(builder: (context, state) {});
    return getBuildSuggestions2(busRoutes);
  }

  Widget getBuildSuggestions(Map<String, Set<Polyline>> busRoutes) {
    return ListView.separated(
      itemBuilder: (context, i) => ListTile(
        title: Text(
          'Linea ${busRoutes.keys.elementAt(i)}',
          style: const TextStyle(color: Colors.black),
        ),
        leading: const FaIcon(
          FontAwesomeIcons.bus,
          color: Colors.black,
        ),
        onTap: () {
          final res = SearResult(
            cancel: false,
            resultPolylines: busRoutes.values.elementAt(i),
          );
          close(context, res);
        },
      ),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: busRoutes.length,
    );
  }

  Widget getBuildSuggestions2(Map<String, Set<Polyline>> busRoutes) {
    return ListView.separated(
      itemBuilder: (context, index) => getSlidable(busRoutes, index, context),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: busRoutes.length,
    );
  }

  Widget getSlidable(
      Map<String, Set<Polyline>> busRoutes, int index, BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: _getSlidableAction(busRoutes, index),
      ),
      child: ListTile(
        title: Text(
          'Linea ${busRoutes.keys.elementAt(index)}',
          style: const TextStyle(color: Colors.black),
        ),
        leading: const FaIcon(
          FontAwesomeIcons.bus,
          color: Colors.black87,
        ),
        trailing: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  List<Widget> _getSlidableAction(
      Map<String, Set<Polyline>> busRoutes, int index) {
    List<String> options = ['Ida', 'vuelta', 'Ambos'];
    List<Color> colors = [Colors.grey.withOpacity(0.2), Colors.grey.withOpacity(0.5), Colors.grey.withOpacity(0.8)];
    List<IconData> icons = [
      Icons.arrow_upward,
      Icons.arrow_downward,
      Icons.swap_vert
    ];
    List<Widget> listaSlide = [];
    Set<Polyline> polylines;
    for (int i = 0; i < options.length; i++) {
      Widget slidableAction = SlidableAction(
          label: options[i],
          flex: 2,
          backgroundColor: colors[i],
          foregroundColor: Colors.black,
          icon: icons[i],
          onPressed: (context) {
            //0=ida | 1=vuelta
            polylines = ((i == 0) | (i == 1)) 
                ? ({busRoutes.values.elementAt(index).elementAt(i)})
                : (busRoutes.values.elementAt(index));
            close(
                context, SearResult(cancel: false, resultPolylines: polylines));
          });
      listaSlide.add(slidableAction);
    }
    return listaSlide;
  }
}
