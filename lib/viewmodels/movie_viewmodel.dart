import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/api.dart';

class ProductViewModel extends ChangeNotifier {
  List<Movie> _movies = [];
  bool _loading = false;
  int _page = 1;

  List<Movie> get products => _movies;
  bool get loading => _loading;
  int get page => _page;

  Future<void> fetchMovies() async {
    _loading = true;
    notifyListeners();

    try {
      _movies = await ApiService().fetchMovies();
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
