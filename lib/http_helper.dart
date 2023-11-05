import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=4ee02f83f66d823bc389dd2405196f88';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=ko-KR';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=4ee02f83f66d823bc389dd2405196f88&query=';

  Future<List?> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response result = await http.get(Uri.parse(query));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
