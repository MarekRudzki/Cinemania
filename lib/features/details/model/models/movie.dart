import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
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

  Movie({
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
  });

  factory Movie.fromJson(
    Map<String, dynamic> detailsJson,
    List<dynamic> imagesJson,
    List<dynamic> castJson,
  ) {
    final List<String> images = [];
    final List<CastMember> cast = [];
    final List<Genre> genres = [];

    final imagesDataList =
        imagesJson.map((e) => e as Map<String, dynamic>).toList();
    final castDataList =
        castJson.map((e) => e as Map<String, dynamic>).toList();
    final genresDynamic = detailsJson['genres'] as List<dynamic>;
    final genresDataList =
        genresDynamic.map((e) => e as Map<String, dynamic>).toList();

    final String basicUrl = detailsJson['poster_path'] != null
        ? detailsJson['poster_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

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

    return Movie(
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
    );
  }

  @override
  List<Object?> get props => [
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
