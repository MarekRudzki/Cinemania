// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';

class TVShow extends Equatable {
  final int id;
  final String url;
  final String begginingDate;
  final String endingDate;
  final List<Genre> genres;
  final String title;
  final int seasonsNumber;
  final int episodesNumber;
  final String overview;
  final double voteAverage;
  final List<String> images;
  final List<CastMember> cast;
  final List<BasicModel> similarTVShows;

  TVShow({
    required this.id,
    required this.url,
    required this.begginingDate,
    required this.endingDate,
    required this.genres,
    required this.title,
    required this.seasonsNumber,
    required this.episodesNumber,
    required this.overview,
    required this.voteAverage,
    required this.images,
    required this.cast,
    required this.similarTVShows,
  });

  factory TVShow.fromJson(
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

    final castDynamic = (detailsJson['aggregate_credits']
        as Map<String, dynamic>)['cast'] as List<dynamic>;
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

    return TVShow(
      id: detailsJson['id'] as int,
      url: fullUrl,
      begginingDate: detailsJson['first_air_date'] != null
          ? detailsJson['first_air_date'] as String
          : 'No data',
      endingDate: detailsJson['last_air_date'] != null
          ? detailsJson['last_air_date'] as String
          : 'No data',
      genres: genres,
      title: detailsJson['name'] != null
          ? detailsJson['name'] as String
          : 'No data',
      seasonsNumber: detailsJson['number_of_seasons'] != null
          ? detailsJson['number_of_seasons'] as int
          : 0,
      episodesNumber: detailsJson['number_of_episodes'] != null
          ? detailsJson['number_of_episodes'] as int
          : 0,
      overview: detailsJson['overview'] != null
          ? detailsJson['overview'] as String
          : 'No data',
      voteAverage: detailsJson['vote_average'] != null
          ? detailsJson['vote_average'] as double
          : 0.0,
      images: images,
      cast: cast,
      similarTVShows: recommendations,
    );
  }

  @override
  List<Object?> get props => [
        id,
        url,
        begginingDate,
        endingDate,
        genres,
        title,
        seasonsNumber,
        episodesNumber,
        overview,
        images,
      ];
}
