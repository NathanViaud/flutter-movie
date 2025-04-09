import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String apiUrl = 'https://www.episodate.com/api';

  Future<(List<Movie>, int)> fetchMovies(int page) async {
    final type = 'most-popular';
    final response = await http.get(Uri.parse('$apiUrl/$type?page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> shows = data['tv_shows'];
      int pages = data['pages'];

      return (
        shows.map((json) => Movie.fromJson(json)).toList(),
        pages
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$apiUrl/search?q=$query&page=1'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body)['tv_shows'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
