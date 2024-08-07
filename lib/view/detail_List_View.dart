import 'package:api_app/res/constants/app_colors.dart';
import 'package:api_app/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/movie_view_model.dart';

class MovieDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Color(kGreen.value),
        title: 'Your Favourite Movie',
          showBackArrow:true,
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.errorMessage.isNotEmpty
          ? Center(child: Text(movieProvider.errorMessage))
          : movieProvider.selectedMovie != null
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movieProvider.selectedMovie!.poster != null &&
                  movieProvider.selectedMovie!.poster!.isNotEmpty)
                Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      width: MediaQuery.of(context).size.width*1,
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
                      child: Image.network(
                        movieProvider.selectedMovie!.poster!,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ))
              else
                Center(child: Text("No Image Found")),

              const SizedBox(height: 16),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(kLight.value),
                  border: Border.all(color: Color(kDark.value), width: 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      movieProvider.selectedMovie!.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ..._buildDetailRows(movieProvider),
              const SizedBox(height: 16),
              if (movieProvider.selectedMovie!.ratings != null &&
                  movieProvider.selectedMovie!.ratings!.isNotEmpty)
                ...movieProvider.selectedMovie!.ratings!.map(
                      (rating) =>
                      _buildDetailRow(
                        rating.source ?? 'Unknown',
                        rating.value ?? 'N/A',
                      ),
                ).toList()
              else
                _buildDetailRow('Ratings', 'No ratings available'),
            ],
          ),
        ),
      )
          : const Center(child: Text('No Movie Details Found')),
    );
  }

  List<Widget> _buildDetailRows(MovieViewModel movieProvider) {
    final details = {
      'Year': movieProvider.selectedMovie!.year ?? 'N/A',
      'Rated': movieProvider.selectedMovie!.rated ?? 'N/A',
      'Released': movieProvider.selectedMovie!.released ?? 'N/A',
      'Runtime': movieProvider.selectedMovie!.runtime ?? 'N/A',
      'Genre': movieProvider.selectedMovie!.genre ?? 'N/A',
      'Director': movieProvider.selectedMovie!.director ?? 'N/A',
      'Writer': movieProvider.selectedMovie!.writer ?? 'N/A',
      'Actors': movieProvider.selectedMovie!.actors ?? 'N/A',
      'Plot': movieProvider.selectedMovie!.plot ?? 'N/A',
      'Language': movieProvider.selectedMovie!.language ?? 'N/A',
      'Country': movieProvider.selectedMovie!.country ?? 'N/A',
      'Awards': movieProvider.selectedMovie!.awards ?? 'N/A',
      'Metascore': movieProvider.selectedMovie!.metascore ?? 'N/A',
      'IMDb Rating': movieProvider.selectedMovie!.imdbRating ?? 'N/A',
      'IMDb Votes': movieProvider.selectedMovie!.imdbVotes ?? 'N/A',
      'Box Office': movieProvider.selectedMovie!.boxOffice ?? 'N/A',
      'Production': movieProvider.selectedMovie!.production ?? 'N/A',
      'Website': movieProvider.selectedMovie!.website ?? 'N/A',
    };

    return details.entries.map((entry) => _buildDetailRow(entry.key, entry.value)).toList();
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$title:',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$value',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
