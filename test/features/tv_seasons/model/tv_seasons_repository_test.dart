import 'package:cinemania/features/tv_seasons/model/datasources/remote_datasources/tv_seasons_tmdb.dart';
import 'package:cinemania/features/tv_seasons/model/models/episode.dart';
import 'package:cinemania/features/tv_seasons/model/models/season.dart';
import 'package:cinemania/features/tv_seasons/model/tv_seasons_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVSeasonsTMDB extends Mock implements TVSeasonsTMDB {}

void main() {
  late TVSeasonsRepository sut;
  late TVSeasonsTMDB tmdb;

  setUp(() {
    tmdb = MockTVSeasonsTMDB();
    sut = TVSeasonsRepository(tmdb: tmdb);
  });

  test(
    'should fetch given season data',
    () async {
      final Map<String, dynamic> json = {
        'overview': 'TV Seasons test',
        'vote_average': 10.0,
        'episodes': [
          {
            'air_date': '2024-03-21',
            'episode_number': 10,
            'name': 'Episode test',
            'overview': 'Episode one test',
            'runtime': 60,
            'still_path': '/testing.jpg',
            'vote_average': 10.0,
          }
        ]
      };
      final Season seasonData = Season(
        overview: 'TV Seasons test',
        voteAverage: 10.0,
        episodes: [
          Episode(
            releaseDate: '2024-03-21',
            number: 10,
            title: 'Episode test',
            overview: 'Episode one test',
            runtime: 60,
            photoUrl: 'https://image.tmdb.org/t/p/w500/testing.jpg',
            voteAverage: 10.0,
          ),
        ],
      );
      when(() => tmdb.fetchSeasonData(id: 1, seasonNumber: 1))
          .thenAnswer((_) async => json);

      final tmdbData = await sut.fetchSeasonData(id: 1, seasonNumber: 1);

      expect(tmdbData, seasonData);
    },
  );
}
