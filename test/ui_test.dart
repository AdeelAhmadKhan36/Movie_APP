import 'package:api_app/data/model/movie_model.dart';
import 'package:api_app/view/detail_List_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:api_app/view_model/movie_view_model.dart';
import 'package:mockito/mockito.dart';

// Mock class
class MockMovieViewModel extends Mock implements MovieViewModel {}

void main() {
  testWidgets('MovieView displays movie data', (WidgetTester tester) async {
    // Create a mock view model
    final mockViewModel = MockMovieViewModel();

    // Set up mock data
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.errorMessage).thenReturn('');
    when(mockViewModel.movies).thenReturn(MovieModel(
      title: 'Batman',
      year: '2020',
      poster: 'https://example.com/batman.jpg',
      // Add other necessary fields
    ) as List<MovieModel>?);

    // Build the widget tree
    await tester.pumpWidget(
      ChangeNotifierProvider<MovieViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(
          home: MovieDetailsView(),
        ),
      ),
    );

    // Verify the UI displays the movie data
    expect(find.text('Batman'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
