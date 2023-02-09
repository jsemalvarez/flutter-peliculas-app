import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = '7e5de46aba8f155b486beee9b4b4cc4f';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apikey, 'language:': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayRespose = NowPlayRespose.fromRawJson(response.body);

    // print(nowPlayRespose.results[1].title);
    onDisplayMovies = nowPlayRespose.results;

    //notificamos a los widgets de los cambios
    notifyListeners();
  }
}
