

import 'package:api_app/res/constants/app_colors.dart';
import 'package:api_app/utils/app_bar.dart';
import 'package:api_app/view/detail_List_View.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/movie_view_model.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  @override
  void initState() {
    super.initState();
    // Fetch the list of movies when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieViewModel>(context, listen: false).searchMovies('star wars');
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Color(kGreen.value), 
       title: 'Select Your Favourite Movies',
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.errorMessage.isNotEmpty
          ? Center(child: Text(movieProvider.errorMessage))
          : movieProvider.movies != null
          ? ListView.builder(
        itemCount: movieProvider.movies!.length,
        itemBuilder: (context, index) {
          final movie = movieProvider.movies![index];
          return Padding(
            padding: const EdgeInsets.only(top:10, left: 10,right: 10),
            child: Card(
              child: ListTile(
                title: Text(movie.title ?? 'No Title',style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(
                  "Year: ${movie.year ?? 'No Year'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: movie.poster != null && movie.poster!.isNotEmpty
                    ? Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.1,
                     decoration: BoxDecoration(
                       color: Colors.red,
                       border: Border.all(color: Color(kRed.value),width:3),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.7),
                           spreadRadius: 2,
                           blurRadius: 5,
                           offset: const Offset(0, 3), // Shadow position
                         ),
                       ],

                     ),
                    child: Image.network(movie.poster!))
                    : const Icon(Icons.movie),
                onTap: () {
                  Provider.of<MovieViewModel>(context, listen: false)
                      .fetchMovieDetails(movie.imdbID!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsView(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
          : const Center(child: Text('No Movies Found')),
    );
  }
}
