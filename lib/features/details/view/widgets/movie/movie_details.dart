import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_cast.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_info.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_photos.dart';
import 'package:flutter/material.dart';

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
              ),
              MovieInfo(
                budget: movie.budget,
                genres: movie.genres,
                releaseDate: movie.releaseDate,
                revenue: movie.revenue,
                runtime: movie.runtime,
                title: movie.title,
                voteAverage: movie.voteAverage,
              ),
            ],
          ),
          Description(description: movie.overview),
          MovieCast(cast: movie.cast),
          MoviePhotos(photos: movie.images),
        ],
      ),
    );
  }
  //TODO Similar movies..
}