import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String releaseDate;
  final int number;
  final String title;
  final String overview;
  final int runtime;
  final String photoUrl;
  final double voteAverage;

  Episode({
    required this.releaseDate,
    required this.number,
    required this.title,
    required this.overview,
    required this.runtime,
    required this.photoUrl,
    required this.voteAverage,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    final String basicUrl =
        json['still_path'] != null ? json['still_path'] as String : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return Episode(
      releaseDate:
          json['air_date'] != null ? json['air_date'] as String : 'No data',
      number:
          json['episode_number'] != null ? json['episode_number'] as int : 0,
      title: json['name'] != null ? json['name'] as String : 'No data',
      overview:
          json['overview'] != null ? json['overview'] as String : 'No data',
      runtime: json['runtime'] != null ? json['runtime'] as int : 0,
      photoUrl: fullUrl,
      voteAverage:
          json['vote_average'] != null ? json['vote_average'] as double : 0.0,
    );
  }

  @override
  List<Object?> get props => [
        releaseDate,
        number,
        title,
        overview,
        runtime,
        photoUrl,
        voteAverage,
      ];
}
