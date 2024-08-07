import 'package:flutter/foundation.dart';
import '../data/services/api_service.dart';
import '../data/model/movie_model.dart';
import '../data/app_exception/app_exceptions.dart';

class MovieViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();


  List<MovieModel>? _movies;
  MovieModel? _selectedMovie;
  bool _isLoading = false;
  String _errorMessage = '';

  List<MovieModel>? get movies => _movies;
  MovieModel? get selectedMovie => _selectedMovie;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final movies = await _apiService.searchMovies(query);
      _movies = movies;
    } on BadRequestException catch (e) {
      _errorMessage = 'Bad Request: ${e.message}';
    } on UnAuthorizedException catch (e) {
      _errorMessage = 'Unauthorized: ${e.message}';
    } on FetchDataException catch (e) {
      _errorMessage = 'Fetch Error: ${e.message}';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMovieDetails(String movieId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final movie = await _apiService.getMovieDetails(movieId);
      _selectedMovie = movie;
    } on BadRequestException catch (e) {
      _errorMessage = 'Bad Request: ${e.message}';
    } on UnAuthorizedException catch (e) {
      _errorMessage = 'Unauthorized: ${e.message}';
    } on FetchDataException catch (e) {
      _errorMessage = 'Fetch Error: ${e.message}';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
