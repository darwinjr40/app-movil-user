import 'package:flutter/material.dart';

class SearchRouteDelegate extends SearchDelegate {
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
        close(context, null);
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
            close(context, null);
          },
        ),
      ],
    );
  }
}
