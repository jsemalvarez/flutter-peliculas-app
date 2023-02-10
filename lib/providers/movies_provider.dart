import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = '7e5de46aba8f155b486beee9b4b4cc4f';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    // print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final Map<String, dynamic> queryParameters = {
      'api_key': _apikey,
      'language:': _language,
      'page': '1'
    };
    final url = Uri.https(_baseUrl, '/3/movie/now_playing', queryParameters);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayRespose = NowPlayRespose.fromRawJson(response.body);

    // print(nowPlayRespose.results[1].title);
    onDisplayMovies = nowPlayRespose.results;

    //notificamos a los widgets de los cambios
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular',
        {'api_key': _apikey, 'language:': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularRespose = PopularRespose.fromRawJson(response.body);

    print(popularRespose.results[1].title);
    popularMovies = [...popularMovies, ...popularRespose.results];

    //notificamos a los widgets de los cambios
    notifyListeners();
  }
}
