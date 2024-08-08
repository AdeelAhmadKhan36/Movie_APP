import 'package:api_app/res/constants/app_colors.dart';
import 'package:api_app/utils/app_bar.dart';
import 'package:api_app/utils/utils.dart';
import 'package:api_app/view/detail_List_View.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/movie_view_model.dart';


class MovieListView extends StatefulWidget {
  const MovieListView({super.key}); // Constructor

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  @override
  void initState() {
    // Call the superclass's initState method
    super.initState();


    // Fetch the list of movies when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Post frame callback to ensure context is available
      Provider.of<MovieViewModel>(context, listen: false) // Access MovieViewModel without listening to changes
      // Call searchMovies with query 'star wars'
          .searchMovies('star wars')
          .catchError((error) {
        // Handle any errors from the searchMovies method
        Utils().toastMessage('Failed to fetch movies: $error'); // Show error message
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get MovieViewModel from context
    final movieProvider = Provider.of<MovieViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        // Set app bar background color
        backgroundColor: Color(kGreen.value),
        title: 'Select Your Favourite Movies',
        // Do not show back arrow
        showBackArrow: false,
      ),
      body: movieProvider.isLoading
      // Show loading indicator while fetching data
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.errorMessage.isNotEmpty
      // Display error message if present
          ? Center(child: Text(movieProvider.errorMessage))
          : movieProvider.movies != null
          ? ListView.builder(
        // Number of items in the list
        itemCount: movieProvider.movies!.length,
        itemBuilder: (context, index) {
          // Get movie at the current index
          final movie = movieProvider.movies![index];
          return Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 10, right: 10),
            child: Card(
              child: ListTile(
                title: Text(
                  // Display movie title or 'No Title'
                  movie.title ?? 'No Title',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  // Display movie year or 'No Year'
                  "Year: ${movie.year ?? 'No Year'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: movie.poster != null &&
                    movie.poster!.isNotEmpty
                    ? Container(
                  height:
                  MediaQuery.of(context).size.height *
                      0.3, // Set height of poster image
                  width: MediaQuery.of(context).size.width *
                      0.1, // Set width of poster image
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        color: Color(kRed.value), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(0.7),
                        spreadRadius: 2, // Set shadow spread radius
                        blurRadius: 5, // Set shadow blur radius
                        offset: const Offset(
                            0, 3), // Set shadow offset
                      ),
                    ],
                  ),
                  child: Image.network(movie.poster!,
                      errorBuilder: (context, error, stackTrace) {
                        // Handle image loading errors
                        Utils().toastMessage(
                            'Unable to load image: ${movie.poster}');
                        return const Center(child: Icon(Icons.movie)); // Fallback icon
                      }),
                )
                    : const Icon(Icons.movie), // Default icon if no poster
                onTap: () {
                  Provider.of<MovieViewModel>(context,
                      listen: false)
                      .fetchMovieDetails(movie.imdbID!); // Fetch movie details on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsView(), // Navigate to MovieDetailsView
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
          : const Center(child: Text('No Movies Found')), // Display message if no movies are found
    );
  }
}
