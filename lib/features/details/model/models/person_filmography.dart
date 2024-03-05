import 'package:equatable/equatable.dart';

class PersonFilmography extends Equatable {
  final int id;
  final String mediaType;
  final String url;
  final String character;
  final double popularity;
  final String title;
  final String year;

  PersonFilmography({
    required this.id,
    required this.mediaType,
    required this.url,
    required this.character,
    required this.popularity,
    required this.title,
    required this.year,
  });

  factory PersonFilmography.fromJson(Map<String, dynamic> json) {
    final String basicUrl =
        json['poster_path'] != null ? json['poster_path'] as String : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return PersonFilmography(
      id: json['id'] as int,
      mediaType: json['media_type'] as String,
      url: fullUrl,
      character:
          json['character'] != null ? json['character'] as String : 'Unknown',
      popularity:
          json['popularity'] != null ? json['popularity'] as double : 0.0,
      title: json['title'] != null
          ? json['title'] as String
          : json['original_name'] != null
              ? json['original_name'] as String
              : 'No data',
      year: json['release_date'] != null
          ? json['release_date'] as String
          : 'Unknown',
    );
  }

  @override
  List<Object?> get props => [
        id,
        mediaType,
        url,
        character,
        popularity,
        title,
        year,
      ];
}
