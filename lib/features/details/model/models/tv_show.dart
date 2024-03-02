import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:equatable/equatable.dart';

class TVShow extends Equatable {
  final String url;
  final String begginingDate;
  final String endingDate;
  final List<Genre> genres;
  final String title;
  final int seasonsNumber;
  final int episodesNumber;
  final String overview;
  final List<String> images;
  final List<CastMember> cast;

  TVShow({
    required this.url,
    required this.begginingDate,
    required this.endingDate,
    required this.genres,
    required this.title,
    required this.seasonsNumber,
    required this.episodesNumber,
    required this.overview,
    required this.images,
    required this.cast,
  });

  factory TVShow.fromJson(
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
      images.add(image['file_path'] as String);
    }

    for (final entity in castDataList) {
      cast.add(CastMember.fromJson(entity));
    }

    for (final genre in genresDataList) {
      genres.add(Genre.fromJson(genre));
    }

    return TVShow(
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
      images: images,
      cast: cast,
    );
  }

  @override
  List<Object?> get props => [
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
