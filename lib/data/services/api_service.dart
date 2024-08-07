import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';
import '../app_exception/app_exceptions.dart';
import 'base_api_service.dart';

class ApiService extends BaseApiService {
  final String apiKey = 'bf273dec'; // Your API key
  final String baseUrl = 'http://www.omdbapi.com/';

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?s=$query&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Response'] == 'True') {
          List<MovieModel> movies = (jsonResponse['Search'] as List)
              .map((data) => MovieModel.fromJson(data))
              .toList();
          return movies;
        } else {
          throw FetchDataException('Movies not found');
        }
      } else {
        throw _handleHttpErrors(response.statusCode);
      }
    } catch (e) {
      throw FetchDataException('An error occurred while fetching movie data');
    }
  }

  @override
  Future<MovieModel> getMovieDetails(String movieId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?i=$movieId&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Response'] == 'True') {
          return MovieModel.fromJson(jsonResponse);
        } else {
          throw FetchDataException('Movie details not found');
        }
      } else {
        throw _handleHttpErrors(response.statusCode);
      }
    } catch (e) {
      throw FetchDataException('An error occurred while fetching movie details');
    }
  }

  Exception _handleHttpErrors(int statusCode) {
    switch (statusCode) {
      case 400:
        return BadRequestException('Invalid request');
      case 401:
        return UnAuthorizedException('Unauthorized request');
      case 403:
        return UnAuthorizedException('Forbidden request');
      case 404:
        return FetchDataException('Resource not found');
      default:
        return FetchDataException('Error during data communication');
    }
  }
}
