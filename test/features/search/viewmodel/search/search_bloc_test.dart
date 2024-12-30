// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/search/model/models/search_history_entry.dart';
import 'package:cinemania/features/search/model/search_repository.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  late SearchBloc sut;
  late SearchRepository searchRepository;

  setUp(() {
    searchRepository = MockSearchRepository();
    sut = SearchBloc(searchRepository);
  });

  group('should fetch searched data', () {
    final List<Category> categories = [
      Category.movies,
      Category.tvShows,
      Category.cast,
    ];
    final BasicModel testModel = BasicModel(
      id: 1,
      imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
      gender: 0,
      name: 'Test',
    );

    for (int i = 0; i < categories.length; i++) {
      blocTest<SearchBloc, SearchState>(
        'emits [MyState] when MyEvent is added.',
        build: () {
          when(() => searchRepository.fetchMovies(
              query: any(named: 'query'), page: any(named: 'page'))).thenAnswer(
            (_) async => [testModel],
          );

          when(() => searchRepository.fetchTvShows(
              query: any(named: 'query'), page: any(named: 'page'))).thenAnswer(
            (_) async => [testModel],
          );

          when(() => searchRepository.fetchCast(
              query: any(named: 'query'), page: any(named: 'page'))).thenAnswer(
            (_) async => [testModel],
          );

          return sut;
        },
        act: (bloc) => bloc
            .add(SearchPressed(searchQuery: 'Test', category: categories[i])),
        expect: () => [
          SearchLoading(),
          SearchSuccess(
            category: categories[i],
            titles: [testModel],
          )
        ],
      );
    }
  });

  blocTest<SearchBloc, SearchState>(
    'emits [SearchInitial] when ResetSearch is added.',
    build: () => sut,
    act: (bloc) => bloc.add(ResetSearch()),
    expect: () => [
      SearchInitial(),
    ],
  );

  group('should change category', () {
    final List<Category> categories = [
      Category.movies,
      Category.tvShows,
      Category.cast,
    ];

    for (int i = 0; i < categories.length; i++) {
      blocTest<SearchBloc, SearchState>(
        'emits [CategoryChanged] when ChangeCategoryPressed with ${categories[i]}',
        build: () => sut,
        act: (bloc) => bloc.add(ChangeCategoryPressed(category: categories[i])),
        expect: () => [
          CategoryChanged(),
        ],
      );

      test(
        "change local bloc category to ${categories[i]}",
        () async {
          sut.add(ChangeCategoryPressed(category: categories[i]));
          await Future.delayed(const Duration(milliseconds: 100));
          expect(sut.currentCategory, categories[i]);
          expect(sut.searchQuery, '');
        },
      );
    }
  });

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

  blocTest<SearchBloc, SearchState>(
    'emits [SearchLoading] and [UserSearches] when GetUserSearchesPressed is added.',
    build: () {
      final List<SearchHistoryEntry> searches = [
        SearchHistoryEntry(text: 'Test', category: Category.movies),
      ];

      when(() => searchRepository.getUserSearches())
          .thenAnswer((_) async => searches);
      return sut;
    },
    act: (bloc) => bloc.add(GetUserSearchesPressed()),
    expect: () => [
      SearchLoading(),
      UserSearches(searches: [
        SearchHistoryEntry(text: 'Test', category: Category.movies),
      ]),
    ],
  );
}
