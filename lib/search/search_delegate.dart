import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

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
    final moviesProvider = Provider.of<MoviesProvider>(context);

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
    return FutureBuilder(
        future: moviesProvider.getMoviesBySearch(query),
        builder: ((context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) return _defaultView();

          final movies = snapshot.data;
          return ListView.builder(
              itemCount: movies?.length,
              itemBuilder: ((context, index) =>
                  _MovieItem(movie: movies![index])));
        }));
  }
}

Widget _defaultView() {
  return Container(
    child: const Center(
        child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.indigo,
      size: 130,
    )),
  );
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
