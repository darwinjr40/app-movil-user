import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    print('test ${result}');
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final busRoutes = BusRoutes.routes;
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
          //TODO: algo
        },
      ),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: busRoutes.length,
    );
  }
}
