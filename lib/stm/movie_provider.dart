import 'package:flutter/material.dart';

import '../services/tmdb_service.dart';

class MovieProvider with ChangeNotifier {
  Map<String, dynamic>? _trendingMovieData;
  Map<String, dynamic>? _popularMovieData;
  Map<String, dynamic>? _playedMovieData;
  Map<String, dynamic>? _movieGenres;

  Map<String, dynamic>? _singleActorDetails;
  Map<String, dynamic>? _actorFilmography;
  Map<String, dynamic>? _movieCasts;
  Map<String, dynamic>? _similarMovies;
  Map<String, dynamic>? _movieReviews;
  Map<String, dynamic>? _detailedMovieInfo;
  Map<String, dynamic>? _castCrew;
  Map<String, dynamic>? _actorImages;
  Map<String, dynamic>? _movieImages;

  Map<String, dynamic>? get trendingMovieData => _trendingMovieData;
  Map<String, dynamic>? get popularMovieData => _popularMovieData;
  Map<String, dynamic>? get playedMovieData => _playedMovieData;
  Map<String, dynamic>? get movieGenres => _movieGenres;
  Map<String, dynamic>? get singleActorDetails => _singleActorDetails;
  Map<String, dynamic>? get actorFilmography => _actorFilmography;
  Map<String, dynamic>? get movieCasts => _movieCasts;
  Map<String, dynamic>? get similarMovies => _similarMovies;
  Map<String, dynamic>? get movieReviews => _movieReviews;
  Map<String, dynamic>? get detailedMovieInfo => _detailedMovieInfo;
  Map<String, dynamic>? get castCrew => _castCrew;
  Map<String, dynamic>? get actorImages => _actorImages;
  Map<String, dynamic>? get movieImages => _movieImages;

  void getTrendingMovies(String token) {
    TMDBService().trendingMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _trendingMovieData = {
          "movies": data,
          "success": true,
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

  void getActorImages(String apiKey, String actorId) {
    TMDBService().getActorImages((message, statusCode, data) {
      if (statusCode == 200) {
        _actorImages = {"profiles": data, "success": true, "message": message};
      } else {
        _actorImages = {"profiles": null, "success": false, "message": message};
      }
      notifyListeners();
    }, actorId, apiKey);
  }

  void getMovieImages(String apiKey, String movieId) {
    TMDBService().getMovieImages((message, statusCode, data) {
      if (statusCode == 200) {
        _movieImages = {"profiles": data, "success": true, "message": message};
      } else {
        _movieImages = {"profiles": null, "success": false, "message": message};
      }
      notifyListeners();
    }, movieId, apiKey);
  }

  void getActorFilmography(String apiKey, String actorId) {
    TMDBService().getSingleActorFilmography((message, statusCode, data) {
      if (statusCode == 200) {
        _actorFilmography = {
          "movies": data,
          "success": true,
          "message": message
        };
      } else {
        _actorFilmography = {
          "movies": null,
          "success": false,
          "message": message
        };
      }
      debugPrint("Actor philmography $_actorFilmography =============> ");
      notifyListeners();
    }, actorId, apiKey);
  }

  void getCastCrew(String apiKey, String movieId) {
    TMDBService().getCastCrew((message, statusCode, data) {
      if (statusCode == 200) {
        _castCrew = {"castCrew": data, "success": true, "message": message};
      } else {
        _castCrew = {"castCrew": null, "success": false, "message": message};
      }
      notifyListeners();
    }, movieId, apiKey);
  }

  void getDetailedMovieInfo(String apiKey, String movieId) {
    TMDBService().getSingleMovieInfo((message, statusCode, data) {
      if (statusCode == 200) {
        _detailedMovieInfo = {
          "info": data,
          "success": true,
          "message": message
        };
      } else {
        _detailedMovieInfo = {
          "info": null,
          "success": false,
          "message": message
        };
      }
      debugPrint("Movie detailed info: $_detailedMovieInfo ==========> ");
      notifyListeners();
    }, movieId, apiKey);
  }

  void getMovieReviews(String apiKey, String movieId) {
    TMDBService().getMovieReviews((message, statusCode, data) {
      if (statusCode == 200) {
        _movieReviews = {"reviews": data, "success": true, "message": message};
      } else {
        _movieReviews = {"reviews": null, "success": false, "message": message};
      }
      debugPrint("Reviews detail: $_movieReviews ---------------> ");
      notifyListeners();
    }, movieId, apiKey);
  }

  void getSimilarMovies(String apiKey, String movieId) {
    TMDBService().getSimilarMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _similarMovies = {"movies": data, "success": true, "message": message};
      } else {
        _similarMovies = {"movies": null, "success": false, "message": message};
      }
      notifyListeners();
    }, movieId, apiKey);
  }

  void getMovieCasts(String apiKey, String movieId) {
    TMDBService().getMovieCasts((message, statusCode, data) {
      if (statusCode == 200) {
        _movieCasts = {"movies": data, "success": true, "message": message};
      } else {
        _movieCasts = {"movies": null, "success": false, "message": message};
      }
      notifyListeners();
    }, movieId, apiKey);
  }

  void getActorDetails(String apiKey, String actorId) {
    TMDBService().getSingleActorDetails((message, statusCode, data) {
      if (statusCode == 200) {
        _singleActorDetails = {
          "actor": data,
          "success": true,
          "message": message
        };
      } else {
        _singleActorDetails = {
          "actor": null,
          "success": false,
          "message": message
        };
      }
      debugPrint("Actor is $_singleActorDetails ========> ");
      notifyListeners();
    }, actorId, apiKey);
  }

  void getMovieGenres(String token) {
    TMDBService().genresForMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _movieGenres = {"genres": data, "success": true, "message": message};
      } else {
        _movieGenres = {"genres": null, "success": false, "message": message};
      }
      notifyListeners();
    }, token);
  }

  void getPopularMovies(String token) {
    TMDBService().popularMovies((message, statusCode, data) {
      if (statusCode == 200) {
        _popularMovieData = {
          "movies": data,
          "success": true,
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
          "success": true,
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
