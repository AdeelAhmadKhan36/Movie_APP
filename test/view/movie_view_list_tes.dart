import 'package:api_app/data/model/movie_model.dart';
import 'package:api_app/view/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:api_app/view_model/movie_view_model.dart';

class MockMovieViewModel extends Mock implements MovieViewModel {}

void main() {
  testWidgets('displays loading indicator while fetching data', (WidgetTester tester) async {
    final mockMovieViewModel = MockMovieViewModel();

    when(mockMovieViewModel.isLoading).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<MovieViewModel>.value(
          value: mockMovieViewModel,
          child: MovieListView(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when there is an error', (WidgetTester tester) async {
    final mockMovieViewModel = MockMovieViewModel();

    when(mockMovieViewModel.isLoading).thenReturn(false);
    when(mockMovieViewModel.errorMessage).thenReturn('An error occurred');
    when(mockMovieViewModel.movies).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<MovieViewModel>.value(
          value: mockMovieViewModel,
          child: MovieListView(),
        ),
      ),
    );

    expect(find.text('An error occurred'), findsOneWidget);
  });

  testWidgets('displays movie list when data is available', (WidgetTester tester) async {
    final mockMovieViewModel = MockMovieViewModel();
    final movies = [
      MovieModel(title: 'Movie Title', year: '2024', imdbID: 'tt0123456')
    ];

    when(mockMovieViewModel.isLoading).thenReturn(false);
    when(mockMovieViewModel.errorMessage).thenReturn('');
    when(mockMovieViewModel.movies).thenReturn(movies);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<MovieViewModel>.value(
          value: mockMovieViewModel,
          child: MovieListView(),
        ),
      ),
    );

    expect(find.text('Movie Title'), findsOneWidget);
  });
}
