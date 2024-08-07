import 'package:api_app/data/model/movie_model.dart';
import 'package:api_app/data/services/api_service.dart';

class MovieRepository {
  final ApiService _apiService;

  // Constructor with dependency injection
  MovieRepository({required ApiService apiService}) : _apiService = apiService;

  /// Fetches a list of movies based on the search query.
  Future<List<MovieModel>> searchMovies(String query) async {
    return await _apiService.searchMovies(query);
  }

  /// Fetches details of a single movie based on the movie ID.
  Future<MovieModel> getMovieDetails(String id) async {
    return await _apiService.getMovieDetails(id);
  }
}
