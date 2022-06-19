import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
     final busService =  BlocProvider.of<BusBloc>(context); 
    // state.routes.keys.elementAt(1);
    // return BlocBuilder<BusBloc, BusState>(builder: (context, state) {
      return ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title: Text(
            'Linea ${busService.state.routes.keys.elementAt(i)}',
            style: const TextStyle(color: Colors.black),
          ),
          leading: const FaIcon(
            FontAwesomeIcons.bus,
            color: Colors.black,
          ),
          onTap: () {
            final res = SearResult(
              cancel: false,
              resultPolylines: busService.state.routes.values.elementAt(i),
            );
            close(context, res);
          },
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: busService.state.routes.length,
      );
    // });
  }
}
