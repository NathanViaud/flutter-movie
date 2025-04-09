import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/api.dart';

class ProductViewModel extends ChangeNotifier {
  List<Movie> _movies = [];
  bool _loading = false;
  int _page = 1;
  int _totalPages = 1; // Add total pages property

  List<Movie> get products => _movies;
  bool get loading => _loading;
  int get page => _page;
  int get totalPages => _totalPages; // Add getter for total pages

  set page(int value) {
    _page = value;
    notifyListeners();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    _loading = true;
    notifyListeners();

    try {
      final result = await ApiService().fetchMovies(_page);
      _movies = result.$1; // Get movies list
      _totalPages = result.$2; // Get total pages
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
