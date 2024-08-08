import 'package:api_app/data/model/movie_model.dart';

//Creating Abstarct class defining the contract for API services
abstract class BaseApiService {
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieModel> getMovieDetails(String movieId);
}
