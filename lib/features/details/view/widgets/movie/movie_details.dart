// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/view/widgets/common/cast.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/common/genres.dart';
import 'package:cinemania/features/details/view/widgets/common/photos.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/common/similar_titles.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_info.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryPhoto(
                photoUrl: movie.url,
                category: Category.movies,
                name: movie.title,
                id: movie.id,
              ),
              Column(
                children: [
                  MovieInfo(
                    budget: movie.budget,
                    releaseDate: movie.releaseDate,
                    revenue: movie.revenue,
                    runtime: movie.runtime,
                    title: movie.title,
                    voteAverage: movie.voteAverage,
                  ),
                  if (movie.genres.isNotEmpty)
                    Genres(
                      genres: movie.genres,
                      category: Category.movies,
                      sourceId: movie.id,
                    )
                ],
              ),
            ],
          ),
          Description(description: movie.overview),
          if (movie.cast.isNotEmpty)
            Cast(
              cast: movie.cast,
              sourceCategory: Category.movies,
              sourceId: movie.id,
            ),
          if (movie.images.isNotEmpty) Photos(photos: movie.images),
          if (movie.similarMovies.isNotEmpty)
            SimilarTitles(
              movies: movie.similarMovies,
              sourceId: movie.id,
            ),
        ],
      ),
    );
  }
}
