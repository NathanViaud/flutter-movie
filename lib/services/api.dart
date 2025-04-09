import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String baseUrl = "https://www.episodate.com/api";

  Future<(List<Movie>, int)> fetchMovies(int page) async {
    final type = 'most-popular';
    final response = await http.get(Uri.parse('$baseUrl/$type?page=$page'));

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
}
