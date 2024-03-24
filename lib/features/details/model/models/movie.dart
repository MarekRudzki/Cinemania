// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';

class Movie extends Equatable {
  final int id;
  final int budget;
  final List<Genre> genres;
  final String overview;
  final String url;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String title;
  final double voteAverage;
  final List<String> images;
  final List<CastMember> cast;
  final List<BasicModel> similarMovies;

  Movie({
    required this.id,
    required this.budget,
    required this.genres,
    required this.overview,
    required this.url,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.images,
    required this.cast,
    required this.similarMovies,
  });

  factory Movie.fromJson(
    Map<String, dynamic> detailsJson,
  ) {
    final List<String> images = [];
    final List<CastMember> cast = [];
    final List<Genre> genres = [];
    final List<BasicModel> recommendations = [];

    final imagesDynamic = (detailsJson['images']
        as Map<String, dynamic>)['backdrops'] as List<dynamic>;
    final imagesDataList =
        imagesDynamic.map((e) => e as Map<String, dynamic>).toList();

    final castDynamic = (detailsJson['credits'] as Map<String, dynamic>)['cast']
        as List<dynamic>;
    final castDataList =
        castDynamic.map((e) => e as Map<String, dynamic>).toList();

    final genresDynamic = detailsJson['genres'] as List<dynamic>;
    final genresDataList =
        genresDynamic.map((e) => e as Map<String, dynamic>).toList();

    final similarDynamic = (detailsJson['recommendations']
        as Map<String, dynamic>)['results'] as List<dynamic>;
    final similarDataList =
        similarDynamic.map((e) => e as Map<String, dynamic>).toList();

    for (final image in imagesDataList) {
      final imageUrlEndpoint = image['file_path'] as String;
      final String url = 'https://image.tmdb.org/t/p/w500$imageUrlEndpoint';
      images.add(url);
    }

    for (final entity in castDataList) {
      cast.add(CastMember.fromJson(entity));
    }

    for (final genre in genresDataList) {
      genres.add(Genre.fromJson(genre));
    }

    for (final recommendation in similarDataList) {
      recommendations.add(BasicModel.fromJson(recommendation));
    }

    final String basicUrl = detailsJson['poster_path'] != null
        ? detailsJson['poster_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return Movie(
      id: detailsJson['id'] as int,
      budget: detailsJson['budget'] != null ? detailsJson['budget'] as int : 0,
      genres: genres,
      overview: detailsJson['overview'] != null
          ? detailsJson['overview'] as String
          : 'No data',
      url: fullUrl,
      releaseDate: detailsJson['release_date'] != null
          ? detailsJson['release_date'] as String
          : 'No data',
      revenue:
          detailsJson['revenue'] != null ? detailsJson['revenue'] as int : 0,
      runtime:
          detailsJson['runtime'] != null ? detailsJson['runtime'] as int : 0,
      title: detailsJson['title'] != null
          ? detailsJson['title'] as String
          : 'No data',
      voteAverage: detailsJson['vote_average'] != null
          ? detailsJson['vote_average'] as double
          : 0.0,
      images: images,
      cast: cast,
      similarMovies: recommendations,
    );
  }

  @override
  List<Object?> get props => [
        id,
        budget,
        genres,
        overview,
        url,
        releaseDate,
        revenue,
        runtime,
        title,
        voteAverage,
        images,
        cast,
      ];
}
