import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/models/models.dart';

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
    final result = BlocProvider.of<BusBloc>(context).searchWhereLike(query);
    return result.isNotEmpty
        ? getBuildSuggestions2(result)
        : const Center(
            child: Text(
              'No se encontraron resultados, intenta con otro numero',
              style: TextStyle(color: Colors.black87),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //  final busRoutes = BusRoutes.routes;
    // return BlocBuilder<BusBloc, BusState>(builder: (context, state) {});
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    Map<String, Set<Polyline>> busRoutes;
    if (searchBloc.state.displayLegend) {
      busRoutes = BlocProvider.of<SearchBloc>(context).state.routes;
    } else {
      busRoutes = BlocProvider.of<BusBloc>(context).state.routes;
    }
    return getBuildSuggestions2(busRoutes);
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
    final buses = BlocProvider.of<BusBloc>(context).busService.listaBus;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: _getSlidableAction(busRoutes, index),
        extentRatio: 0.88,
      ),
      child: ListTile(        
        title: Text(
          'Linea ${busRoutes.keys.elementAt(index)}',
          style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        leading: Hero(
          tag: index,
          child:  FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            // image: const NetworkImage('https://picsum.photos/250?image=9'),
            image: NetworkImage(buses[index].photo),
            width: 100,
            fit: BoxFit.contain,
          ),
        ),
        // leading: const FaIcon(
        //   FontAwesomeIcons.bus,
        //   color: Colors.black87,
        // ),
        trailing: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  List<Widget> _getSlidableAction(
      Map<String, Set<Polyline>> busRoutes, int index) {
    List<String> options = ['Ida', 'Vuelta', 'Ambos'];
    List<Color> colors = [
      Colors.grey.withOpacity(0.6),
      Colors.grey.withOpacity(0.8),
      Colors.grey
    ];
    List<IconData> icons = [
      Icons.arrow_upward,
      Icons.arrow_downward,
      Icons.swap_vert
    ];
    List<Widget> listaSlide = [];
    Set<Polyline> setPolylines = busRoutes.values.elementAt(index);
    String key = busRoutes.keys.elementAt(index);
    if (setPolylines.isNotEmpty) {
      int k = 0;
      Widget slidableAction;
      int n = setPolylines.length;
      for (int i = 0; i < n + 1; i++) {
        k = 0;
        if (i >= n && n == 2) k = 1;
        if (i < n) {
          String polylineId = setPolylines.elementAt(i).polylineId.value;
          if (polylineId.contains('${key}Ida') ||
              polylineId.contains('${key}Vuelta')) k = 2;
        }

        if (k > 0) {
          slidableAction = SlidableAction(
              label: options[i % 3],
              backgroundColor: colors[i % 3],
              icon: icons[i % 3],
              onPressed: (context) {
                Set<Polyline> polylines =
                    (i >= n) ? (setPolylines) : ({setPolylines.elementAt(i)});
                close(context,
                    SearResult(cancel: false, resultPolylines: polylines));
              });
          listaSlide.add(slidableAction);
        }
      }
    }
    return listaSlide;
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
}
