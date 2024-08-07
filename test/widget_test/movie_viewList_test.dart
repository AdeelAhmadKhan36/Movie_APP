import 'package:api_app/view/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:api_app/view_model/movie_view_model.dart';
import 'package:api_app/data/model/movie_model.dart';

class MockMovieViewModel extends Mock implements MovieViewModel {}

void main() {
  testWidgets('displays loading indicator while fetching data', (WidgetTester tester) async {
    final mockViewModel = MockMovieViewModel();
    when(mockViewModel.isLoading).thenReturn(true);

    await tester.pumpWidget(
      ChangeNotifierProvider<MovieViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(home: MovieListView()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when there is an error', (WidgetTester tester) async {
    final mockViewModel = MockMovieViewModel();
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.errorMessage).thenReturn('An error occurred');

    await tester.pumpWidget(
      ChangeNotifierProvider<MovieViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(home: MovieListView()),
      ),
    );

    expect(find.text('An error occurred'), findsOneWidget);
  });

  testWidgets('displays movie list when data is available', (WidgetTester tester) async {
    final mockViewModel = MockMovieViewModel();
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.errorMessage).thenReturn('');
    when(mockViewModel.movies).thenReturn([
      MovieModel(title: 'Movie1', year: '2020', imdbID: 'tt1234567')
    ]);

    await tester.pumpWidget(
      ChangeNotifierProvider<MovieViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(home: MovieListView()),
      ),
    );

    expect(find.text('Movie1'), findsOneWidget);
  });
}
