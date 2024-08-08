import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';
import '../app_exception/app_exceptions.dart';
import 'base_api_service.dart';

class ApiService extends BaseApiService {
  // Defining API key
  final String apiKey = 'bf273dec';
  // Defining the base URL for the API
  final String baseUrl = 'http://www.omdbapi.com/';

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      // Making a GET request to search for movies
      final response = await http.get(Uri.parse('$baseUrl?s=$query&apikey=$apiKey'));

      if (response.statusCode == 200) {
        // If the request is successful, decode the JSON response
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Response'] == 'True') {
          // If the response indicates success, map the results to MovieModel objects
          List<MovieModel> movies = (jsonResponse['Search'] as List)
              .map((data) => MovieModel.fromJson(data))
              .toList();
          return movies; // Return the list of movies
        } else {
          // If the response indicates failure, throw an exception
          throw FetchDataException('Movies not found');
        }
      } else {
        // Handle HTTP errors based on status code
        throw _handleHttpErrors(response.statusCode);
      }
    } catch (e) {
      // Catch and rethrow exceptions with a custom message
      throw FetchDataException('An error occurred while fetching movie data');
    }
  }

  @override
  Future<MovieModel> getMovieDetails(String movieId) async {
    try {
      // Make a GET request to fetch movie details
      final response = await http.get(Uri.parse('$baseUrl?i=$movieId&apikey=$apiKey'));

      if (response.statusCode == 200) {
        // If the request is successful, decode the JSON response
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['Response'] == 'True') {
          // If the response indicates success, convert it to a MovieModel object
          return MovieModel.fromJson(jsonResponse);
        } else {
          // If the response indicates failure, throw an exception
          throw FetchDataException('Movie details not found');
        }
      } else {
        // Handle HTTP errors based on status code
        throw _handleHttpErrors(response.statusCode);
      }
    } catch (e) {
      // Catch and rethrow exceptions with a custom message
      throw FetchDataException('An error occurred while fetching movie details');
    }
  }

  Exception _handleHttpErrors(int statusCode) {
    // Handling different HTTP status codes and return corresponding exceptions
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
