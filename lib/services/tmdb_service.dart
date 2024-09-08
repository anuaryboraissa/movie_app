import "dart:convert";

import "package:http/http.dart" as http;
import "package:movie_app/services/models/actor_detail.dart";
import "package:movie_app/services/models/actor_philmography.dart";
import "package:movie_app/services/models/cast_crew.dart";
import "package:movie_app/services/models/movie.dart";
import "package:movie_app/services/models/movie_cast.dart";
import "package:movie_app/services/models/movie_review/movie_review.dart";
import "package:movie_app/services/models/person_image.dart";
import "package:movie_app/services/models/single_movie_info/single_movie_info.dart";

import "models/genre.dart";

class TMDBService {
  final domain = "https://api.themoviedb.org/3";
  trendingMovies(
      Function(String message, int statusCode, dynamic data) callback,
      String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request =
          http.Request('GET', Uri.parse('$domain/trending/movie/day'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<Movie> movies = (responseBody["results"] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        callback("success", 200, movies);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  popularMovies(Function(String message, int statusCode, dynamic data) callback,
      String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
          'GET',
          Uri.parse(
              '$domain/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<Movie> movies = (responseBody["results"] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        callback("success", 200, movies);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  currentlyPlayedMovies(
      Function(String message, int statusCode, dynamic data) callback,
      String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
          'GET',
          Uri.parse(
              '$domain/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<Movie> movies = (responseBody["results"] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        callback("success", 200, movies);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  genresForMovies(
      Function(String message, int statusCode, dynamic data) callback,
      String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET', Uri.parse('$domain/genre/movie/list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<Genre> genres = (responseBody["genres"] as List)
            .map((e) => Genre.fromJson(e))
            .toList();
        callback("success", 200, genres);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getSingleActorDetails(
      Function(String message, int statusCode, dynamic data) callback,
      String actorId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/person/$actorId?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        ActorDetail actorDetail = ActorDetail.fromJson(responseBody);
        callback("success", 200, actorDetail);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getSingleActorFilmography(
      Function(String message, int statusCode, dynamic data) callback,
      String actorId,
      String apiKey) async {
    try {
      var request = http.Request('GET',
          Uri.parse('$domain/person/$actorId/movie_credits?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<ActorPhilmography> philmography = (responseBody["cast"] as List)
            .map((e) => ActorPhilmography.fromJson(e))
            .toList();
        callback("success", 200, philmography);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getActorImages(
      Function(String message, int statusCode, dynamic data) callback,
      String actorId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/person/$actorId/images?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<PersonImage> profiles = (responseBody["profiles"] as List)
            .map((e) => PersonImage.fromJson(e))
            .toList();
        callback("success", 200, profiles);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getMovieImages(
      Function(String message, int statusCode, dynamic data) callback,
      String movieId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId/images?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<PersonImage> profiles = (responseBody["backdrops"] as List)
            .map((e) => PersonImage.fromJson(e))
            .toList();
        callback("success", 200, profiles);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getMovieCasts(Function(String message, int statusCode, dynamic data) callback,
      String movieId, String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId/casts?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<MovieCast> movieCasts = (responseBody["cast"] as List)
            .map((e) => MovieCast.fromJson(e))
            .toList();
        callback("success", 200, movieCasts);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getSimilarMovies(
      Function(String message, int statusCode, dynamic data) callback,
      String movieId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId/similar?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<Movie> similarMovies = (responseBody["results"] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        callback("success", 200, similarMovies);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getMovieReviews(
      Function(String message, int statusCode, dynamic data) callback,
      String movieId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId/reviews?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<MovieReview> movieReviews = (responseBody["results"] as List)
            .map((e) => MovieReview.fromJson(e))
            .toList();
        callback("success", 200, movieReviews);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getCastCrew(Function(String message, int statusCode, dynamic data) callback,
      String movieId, String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId/credits?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        List<CastCrew> castCrews = (responseBody["cast"] as List)
            .map((e) => CastCrew.fromJson(e))
            .toList();
        callback("success", 200, castCrews);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }

  getSingleMovieInfo(
      Function(String message, int statusCode, dynamic data) callback,
      String movieId,
      String apiKey) async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$domain/movie/$movieId?api_key=$apiKey'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody =
            json.decode(await response.stream.bytesToString());

        SingleMovieInfo singleMovieInfo =
            SingleMovieInfo.fromJson(responseBody);
        callback("success", 200, singleMovieInfo);
      } else {
        callback(response.reasonPhrase.toString(), 400, null);
      }
    } catch (e) {
      callback(e.toString(), 400, null);
    }
  }
}
