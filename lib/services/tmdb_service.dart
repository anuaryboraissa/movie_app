import "dart:convert";

import "package:http/http.dart" as http;
import "package:movie_app/services/models/movie.dart";

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
}
