import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/data/services/api_service.dart';
import 'package:api_app/data/model/movie_model.dart';
import 'dart:convert';

// Mock class
class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    test('fetches movies successfully', () async {
      final client = MockClient();
      final apiService = ApiService(client: client);

      // Mock the response
      when(client.get(Uri.parse('http://www.omdbapi.com/?s=batman&apikey=bf273dec')))
          .thenAnswer((_) async => http.Response('{"Search": [{"Title": "Batman", "Year": "2020"}], "Response": "True"}', 200));

      final movies = await apiService.searchMovies('batman');
      expect(movies, isA<List<MovieModel>>());
      expect(movies.first.title, 'Batman');
      expect(movies.first.year, '2020');
    });
  });
}
