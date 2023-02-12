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

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 1;

  MoviesProvider() {
    // print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final Map<String, dynamic> queryParameters = {
      'api_key': _apikey,
      'language:': _language,
      'page': '$page'
    };
    final url = Uri.https(_baseUrl, endpoint, queryParameters);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    // final Map<String, dynamic> queryParameters = {
    //   'api_key': _apikey,
    //   'language:': _language,
    //   'page': '1'
    // };
    // final url = Uri.https(_baseUrl, '/3/movie/now_playing', queryParameters);

    // // Await the http get response, then decode the json-formatted response.
    // final response = await http.get(url);
    final jsonData = await _getJsonData('/3/movie/now_playing');
    final nowPlayRespose = NowPlayRespose.fromRawJson(jsonData);

    // print(nowPlayRespose.results[1].title);
    onDisplayMovies = nowPlayRespose.results;

    //notificamos a los widgets de los cambios
    notifyListeners();
  }

  getPopularMovies() async {
    // var url = Uri.https(_baseUrl, '/3/movie/popular',
    //     {'api_key': _apikey, 'language:': _language, 'page': '1'});

    // // Await the http get response, then decode the json-formatted response.
    // final response = await http.get(url);

    _popularPage++;
    print('Pagina de peliculas populares Nro $_popularPage');
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularRespose = PopularRespose.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularRespose.results];

    //notificamos a los widgets de los cambios
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final jsonData = await _getJsonData('/3/movie/$movieId/credits');
    final creditsRespose = CreditsResponse.fromRawJson(jsonData);

    moviesCast[movieId] = creditsRespose.cast;

    return creditsRespose.cast;
  }
}
