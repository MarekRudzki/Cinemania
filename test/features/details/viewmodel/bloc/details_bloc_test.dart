import 'package:bloc_test/bloc_test.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/details/model/details_repository.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/details/model/models/detail_history.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailsRepository extends Mock implements DetailsRepository {}

void main() {
  late DetailsBloc sut;
  late DetailsRepository detailsRepository;

  setUp(() {
    detailsRepository = MockDetailsRepository();
    sut = DetailsBloc(detailsRepository);
  });

  final Movie movieTest = Movie(
      id: 1,
      budget: 1,
      genres: [Genre(id: 1, name: 'Test')],
      overview: 'Test',
      url: 'https://image.tmdb.org/t/p/w500/test.jpg',
      releaseDate: 'Test',
      revenue: 1,
      runtime: 1,
      title: 'Test',
      voteAverage: 10.0,
      images: ['https://image.tmdb.org/t/p/w500/test.jpg'],
      cast: [
        CastMember(
            character: 'Test',
            gender: 1,
            id: 1,
            name: 'Test',
            url: 'https://image.tmdb.org/t/p/w500/test.jpg')
      ],
      similarMovies: [
        BasicModel(
          id: 1,
          imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
          name: 'Test',
        )
      ]);

  final TVShow tvShowTest = TVShow(
      id: 1,
      begginingDate: 'Test',
      endingDate: 'Test',
      seasonsNumber: 1,
      episodesNumber: 1,
      genres: [Genre(id: 1, name: 'Test')],
      overview: 'Test',
      url: 'https://image.tmdb.org/t/p/w500/test.jpg',
      title: 'Test',
      voteAverage: 10.0,
      images: ['https://image.tmdb.org/t/p/w500/test.jpg'],
      cast: [
        CastMember(
            character: 'Test',
            gender: 1,
            id: 1,
            name: 'Test',
            url: 'https://image.tmdb.org/t/p/w500/test.jpg')
      ],
      similarTVShows: [
        BasicModel(
          id: 1,
          imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
          name: 'Test',
        )
      ]);

  final Person personTest = Person(
      id: 1,
      biography: 'Test',
      birthday: 'Test',
      deathday: 'Test',
      gender: 1,
      name: 'Test',
      height: 100,
      placeOfBirth: 'Test',
      photoUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
      images: [
        'https://image.tmdb.org/t/p/w500/test.jpg'
      ],
      filmography: [
        PersonFilmography(
          id: 1,
          mediaType: 'movie',
          url: 'https://image.tmdb.org/t/p/w500/test.jpg',
          character: 'Test',
          popularity: 1.0,
          title: 'Test',
          year: '1',
        )
      ]);

  test(
    'should add DetailHistory to history list',
    () async {
      sut.add(AddToHistoryPressed(
        id: 1,
        category: Category.movies,
        scrollableListIndex: 1,
        scrollableListCategory: 'cast',
      ));
      await Future.delayed(const Duration(milliseconds: 100));

      expect(sut.history.length, 1);
    },
  );

  test(
    'should remove last element from history list',
    () async {
      sut.history.add(DetailHistory(
        id: 1,
        category: Category.movies,
        scrollableListIndex: 1,
        scrollableListCategory: 'cast',
      ));
      sut.history.add(DetailHistory(
        id: 2,
        category: Category.tvShows,
        scrollableListIndex: 2,
        scrollableListCategory: 'cast',
      ));
      sut.add(DeleteLastHistoryElementPressed());
      await Future.delayed(const Duration(milliseconds: 100));

      expect(sut.history.length, 1);
      expect(
          sut.history.last,
          DetailHistory(
            id: 1,
            category: Category.movies,
            scrollableListIndex: 1,
            scrollableListCategory: 'cast',
          ));
    },
  );

  blocTest<DetailsBloc, DetailsState>(
    'emits [DetailsLoading] and [DetailsSuccess] when FetchMovieDataPressed is added.',
    build: () {
      when(() => detailsRepository.fetchMovieData(id: any(named: 'id')))
          .thenAnswer((_) async => movieTest);
      return sut;
    },
    act: (bloc) => bloc.add(FetchMovieDataPressed(
        id: 1, scrollableListCategory: 'cast', scrollableListIndex: 1)),
    expect: () => [
      DetailsLoading(),
      DetailsSuccess(
        movie: movieTest,
        scrollableListCategory: 'cast',
        scrollableListIndex: 1,
      ),
    ],
  );

  blocTest<DetailsBloc, DetailsState>(
    'emits [DetailsLoading] and [DetailsSuccess] when FetchTVShowDataPressed is added.',
    build: () {
      when(() => detailsRepository.fetchTVShowData(id: any(named: 'id')))
          .thenAnswer((_) async => tvShowTest);
      return sut;
    },
    act: (bloc) => bloc.add(FetchTVShowDataPressed(
        id: 1, scrollableListCategory: 'cast', scrollableListIndex: 1)),
    expect: () => [
      DetailsLoading(),
      DetailsSuccess(
        tvShow: tvShowTest,
        scrollableListCategory: 'cast',
        scrollableListIndex: 1,
      ),
    ],
  );

  blocTest<DetailsBloc, DetailsState>(
    'emits [DetailsLoading] and [DetailsSuccess] when FetchPersonDataPressed is added.',
    build: () {
      when(() => detailsRepository.fetchPersonData(id: any(named: 'id')))
          .thenAnswer((_) async => personTest);
      return sut;
    },
    act: (bloc) => bloc.add(FetchPersonDataPressed(
        id: 1, scrollableListCategory: 'movie', scrollableListIndex: 1)),
    expect: () => [
      DetailsLoading(),
      DetailsSuccess(
        person: personTest,
        scrollableListCategory: 'movie',
        scrollableListIndex: 1,
      ),
    ],
  );
  group('should return proper asset adress', () {
    final List<Map<String, dynamic>> testCases = [
      {'category': Category.movies, 'expectedString': 'assets/movie.png'},
      {'category': Category.tvShows, 'expectedString': 'assets/tv_show.png'},
      {
        'category': Category.cast,
        'gender': 1,
        'expectedString': 'assets/woman.png'
      },
      {
        'category': Category.cast,
        'gender': 2,
        'expectedString': 'assets/man.png'
      },
      {
        'category': Category.cast,
        'expectedString': 'assets/unknown_nonbinary.png'
      },
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['category']}',
        () {
          final String outcome = sut.getAssetAdress(
            category: testCase['category']! as Category,
            gender: testCase['gender'] != null ? testCase['gender']! as int : 0,
          );
          expect(outcome, testCase['expectedString']);
        },
      );
    }
  });

  group('should return person\'s age', () {
    final List<Map<String, dynamic>> testCases = [
      {
        'birthday': '1996-04-17',
        'deathday': 'No data',
        'expectedAge': 27,
      },
      {
        'birthday': '1962-07-11',
        'deathday': '2012-02-26',
        'expectedAge': 49,
      },
      {
        'birthday': '2000-01-12',
        'deathday': 'No data',
        'expectedAge': 24,
      },
      {
        'birthday': '2002-12-12',
        'deathday': 'No data',
        'expectedAge': 21,
      },
      {
        'birthday': '1922-11-22',
        'deathday': 'No data',
        'expectedAge': 101,
      },
      {
        'birthday': '1925-02-26',
        'deathday': '1999-05-02',
        'expectedAge': 74,
      },
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['expectedAge']} y.o.',
        () {
          final int outcome = sut.calculateAge(
            birthday: testCase['birthday']! as String,
            deathday: testCase['deathday']! as String,
          );
          expect(outcome, testCase['expectedAge']);
        },
      );
    }
  });

  group('should proper calculate movie legnth', () {
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
          final String outcome = sut.calculateMovieLength(
            minutes: testCase['minutes']! as int,
          );
          expect(outcome, testCase['expectedString']);
        },
      );
    }
  });

  group('should proper show big number', () {
    final List<Map<String, dynamic>> testCases = [
      {'number': 999, 'expectedString': '999 \$'},
      {'number': 1000, 'expectedString': '1 000 \$'},
      {'number': 10000, 'expectedString': '10 000 \$'},
      {'number': 1000000, 'expectedString': '1 000 000 \$'},
      {'number': 1000000000, 'expectedString': '1 000 000 000 \$'},
      {'number': 1000000000000, 'expectedString': '1 000 000 000 000 \$'},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['number']} \$',
        () {
          final String outcome = sut.showBigNumer(
            number: testCase['number']! as int,
          );
          expect(outcome, testCase['expectedString']);
        },
      );
    }
  });
}
