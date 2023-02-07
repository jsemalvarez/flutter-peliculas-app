import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
  }

  getOnDisplayMovies() {
    print('getOnDisplayMovies');
  }
}
