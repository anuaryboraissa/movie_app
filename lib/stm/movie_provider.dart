import 'package:flutter/material.dart';

import '../services/tmdb_service.dart';

class MovieProvider with ChangeNotifier {
  Map<String, dynamic>? _trendingMovieData;
  Map<String, dynamic>? _popularMovieData;
  Map<String, dynamic>? _playedMovieData;

  Map<String, dynamic>? get trendingMovieData => _trendingMovieData;
  Map<String, dynamic>? get popularMovieData => _popularMovieData;
  Map<String, dynamic>? get playedMovieData => _playedMovieData;

  void getTrendingMovies(String token) {
    TMDBService().trendingMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _trendingMovieData = {
          "movies": data,
          "success": false,
          "message": message
        };
      } else {
        _trendingMovieData = {
          "movies": null,
          "success": false,
          "message": message
        };
      }
      notifyListeners();
    }, token);
  }

  void getPopularMovies(String token) {
    TMDBService().popularMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _popularMovieData = {
          "movies": data,
          "success": false,
          "message": message
        };
      } else {
        _popularMovieData = {
          "movies": null,
          "success": false,
          "message": message
        };
      }
      notifyListeners();
    }, token);
  }

  void getCurrentlyPlayedMovies(String token) {
    TMDBService().currentlyPlayedMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _playedMovieData = {
          "movies": data,
          "success": false,
          "message": message
        };
      } else {
        _playedMovieData = {
          "movies": null,
          "success": false,
          "message": message
        };
      }
      notifyListeners();
    }, token);
  }
}
