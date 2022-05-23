import 'package:flutter/material.dart';
import 'package:micros_user_app/data/models/models.dart';

class SearchRouteDelegate extends SearchDelegate<SearResult> {
  SearchRouteDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
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
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            'Colocar la linea manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            // close(context, null);
          },
        ),
      ],
    );
  }
}
