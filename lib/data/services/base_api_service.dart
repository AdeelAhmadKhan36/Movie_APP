// lib/data/services/base_api_service.dart

import 'package:api_app/data/model/movie_model.dart';

abstract class BaseApiService {
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieModel> getMovieDetails(String movieId);
}
