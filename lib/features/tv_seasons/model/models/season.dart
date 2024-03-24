// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/features/tv_seasons/model/models/episode.dart';

class Season extends Equatable {
  final String overview;
  final double voteAverage;
  final List<Episode> episodes;

  Season({
    required this.overview,
    required this.voteAverage,
    required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    final List<Episode> episodes = [];

    final episodesDynamic = json['episodes'] as List<dynamic>;
    final episodesDataList =
        episodesDynamic.map((e) => e as Map<String, dynamic>).toList();

    for (final episode in episodesDataList) {
      episodes.add(Episode.fromJson(episode));
    }

    return Season(
      overview:
          json['overview'] != null ? json['overview'] as String : 'No data',
      voteAverage:
          json['vote_average'] != null ? json['vote_average'] as double : 0.0,
      episodes: episodes,
    );
  }

  @override
  List<Object?> get props => [
        overview,
        voteAverage,
        episodes,
      ];
}
