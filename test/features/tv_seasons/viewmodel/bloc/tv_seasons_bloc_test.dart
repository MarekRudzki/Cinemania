import 'package:bloc_test/bloc_test.dart';
import 'package:cinemania/features/tv_seasons/model/models/episode.dart';
import 'package:cinemania/features/tv_seasons/model/models/season.dart';
import 'package:cinemania/features/tv_seasons/model/tv_seasons_repository.dart';
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVSeasonsRepository extends Mock implements TVSeasonsRepository {}

void main() {
  late TVSeasonsBloc sut;
  late TVSeasonsRepository tvSeasonsRepository;
  setUp(() {
    tvSeasonsRepository = MockTVSeasonsRepository();
    sut = TVSeasonsBloc(tvSeasonsRepository);
  });
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

  blocTest<TVSeasonsBloc, TVSeasonsState>(
    'emits [TVSeasonsLoading] and [TVSeasonsSuccess] when FetchSeason is added.',
    build: () {
      when(() => tvSeasonsRepository.fetchSeasonData(
              id: any(named: 'id'), seasonNumber: any(named: 'seasonNumber')))
          .thenAnswer((_) async => seasonData);
      return sut;
    },
    act: (bloc) => bloc.add(FetchSeason(id: 1, seasonNumber: 1)),
    expect: () => [
      TVSeasonsLoading(),
      TVSeasonsSuccess(season: seasonData),
    ],
  );

  blocTest<TVSeasonsBloc, TVSeasonsState>(
    'emits [TVSeasonsLoading] and [TVSeasonsError] when FetchSeason is added.',
    build: () {
      when(() => tvSeasonsRepository.fetchSeasonData(
          id: any(named: 'id'),
          seasonNumber: any(named: 'seasonNumber'))).thenThrow('Error occured');
      return sut;
    },
    act: (bloc) => bloc.add(FetchSeason(id: 1, seasonNumber: 1)),
    expect: () => [
      TVSeasonsLoading(),
      TVSeasonsError(
        errorMessage: 'Error occured',
      ),
    ],
  );

  group('should proper calculate legnth', () {
    final List<Map<String, dynamic>> testCases = [
      {'minutes': 0, 'expectedString': '0 min'},
      {'minutes': 1, 'expectedString': '1 min'},
      {'minutes': 59, 'expectedString': '59 min'},
      {'minutes': 60, 'expectedString': '1 h'},
      {'minutes': 61, 'expectedString': '1 h 1 min'},
      {'minutes': 90, 'expectedString': '1 h 30 min'},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['minutes']} minutes',
        () {
          final String outcome = sut.calculateLength(
            minutes: testCase['minutes']! as int,
          );
          expect(outcome, testCase['expectedString']);
        },
      );
    }
  });

  group('should proper calculate seasons bar height', () {
    final testCases = [
      {'seasonsNumber': 1, 'expectedHeight': 45.0},
      {'seasonsNumber': 4, 'expectedHeight': 45.0},
      {'seasonsNumber': 5, 'expectedHeight': 90.0},
      {'seasonsNumber': 8, 'expectedHeight': 90.0},
      {'seasonsNumber': 9, 'expectedHeight': 135.0},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['seasonsNumber']} seasons',
        () {
          final double height = sut.getSeasonsBarHeight(
              seasonsNumber: testCase['seasonsNumber']! as int);
          expect(height, testCase['expectedHeight']);
        },
      );
    }
  });
}
