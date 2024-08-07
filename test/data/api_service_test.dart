import 'dart:convert';
import 'package:api_app/data/app_exception/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:api_app/data/model/movie_model.dart';
import 'package:api_app/data/services/api_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService();
  });

  group('ApiService', () {
    test('returns a list of movies if the http call completes successfully',
        () async {
      final responseJson = jsonEncode({
        'Response': 'True',
        'Search': [
          {
            'Title': 'Movie Title',
            'Year': '2024',
            'imdbID': 'tt0123456',
            'Poster': 'https://example.com/poster.jpg',
          }
        ]
      });

      when(mockClient.get(Uri.parse(
              'http://www.omdbapi.com/?s=star%20wars&apikey=bf273dec')))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      final movies = await apiService.searchMovies('star wars');
      expect(movies, isA<List<MovieModel>>());
      expect(movies.length, 1);
      expect(movies[0].title, 'Movie Title');
    });

    test('throws an exception if the http call completes with an error',
        () async {
      when(mockClient.get(Uri.parse(
              'http://www.omdbapi.com/?s=star%20wars&apikey=bf273dec')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await apiService.searchMovies('star wars'),
          throwsA(isA<FetchDataException>()));
    });
  });
}
