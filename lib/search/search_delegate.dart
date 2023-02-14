import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar . . .';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (() => query = ''), icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() => close(context, null)),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: const Center(
            child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.indigo,
          size: 130,
        )),
      );
    }
    return const Text('buildSuggestions');
  }
}