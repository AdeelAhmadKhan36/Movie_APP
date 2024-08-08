import 'package:flutter/foundation.dart';
import '../data/services/api_service.dart';
import '../data/model/movie_model.dart';
import '../data/app_exception/app_exceptions.dart';


class MovieViewModel with ChangeNotifier {
  // Initialize the API service
  final ApiService _apiService = ApiService();

  // Private variable to hold the list of movies
  List<MovieModel>? _movies;

  // Private variable to hold the selected movie
  MovieModel? _selectedMovie;

  // Private variable to track loading state
  bool _isLoading = false;

  // Private variable to hold error messages
  String _errorMessage = '';

  // Public getter for movies
  List<MovieModel>? get movies => _movies;

  // Public getter for the selected movie
  MovieModel? get selectedMovie => _selectedMovie;

  // Public getter for loading state
  bool get isLoading => _isLoading;

  // Public getter for error messages
  String get errorMessage => _errorMessage;

  // Set loading state to true
  Future<void> searchMovies(String query) async {
    _isLoading = true;

    // Clear previous error messages
    _errorMessage = '';

    // Notify listeners of changes
    notifyListeners();


    try {
      // Fetch movies from the API
      final movies = await _apiService.searchMovies(query);

      // Update the movies list
      _movies = movies;

    } on BadRequestException catch (e) {
      // Handle bad request exceptions
      _errorMessage = 'Bad Request: ${e.message}';

    } on UnAuthorizedException catch (e) {
      // Handle unauthorized exceptions
      _errorMessage = 'Unauthorized: ${e.message}';

    } on FetchDataException catch (e) {
      // Handle data fetch exceptions
      _errorMessage = 'Fetch Error: ${e.message}';

    } catch (e) {
      // Handle any other exceptions
      _errorMessage = 'An unexpected error occurred: $e';

    } finally {
      // Set loading state to false
      _isLoading = false;

      // Notify listeners of changes
      notifyListeners();

    }
  }

  Future<void> fetchMovieDetails(String movieId) async {
    // Set loading state to true
    _isLoading = true;

    // Clear previous error messages
    _errorMessage = '';
    // Notify listeners of changes
    notifyListeners();


    try {
      // Fetch movie details from the API
      final movie = await _apiService.getMovieDetails(movieId);


      _selectedMovie = movie;
      // Update the selected movie
    } on BadRequestException catch (e) {
      _errorMessage = 'Bad Request: ${e.message}';
      // Handle bad request exceptions
    } on UnAuthorizedException catch (e) {
      _errorMessage = 'Unauthorized: ${e.message}';
      // Handle unauthorized exceptions
    } on FetchDataException catch (e) {
      _errorMessage = 'Fetch Error: ${e.message}';
      // Handle data fetch exceptions
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
      // Handle any other exceptions
    } finally {
      _isLoading = false;
      // Set loading state to false

      notifyListeners();
      // Notify listeners of changes
    }
  }
}
