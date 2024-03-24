// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';
import 'package:cinemania/features/home/model/datasources/models/home_page_model.dart';
import 'package:cinemania/features/home/model/home_repository.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:cinemania/features/home/viewmodel/random_dates_generator.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeBloc sut;
  late HomeRepository homeRepository;

  setUp(() {
    homeRepository = MockHomeRepository();
    sut = HomeBloc(homeRepository);
  });

  final BasicModel testModel = BasicModel(
    id: 1,
    imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
    gender: 0,
    name: 'Test',
  );

  final Genre testGenre = Genre(id: 1, name: 'Test');

  group('should get categories list -', () {
    test(
      'normal',
      () {
        final List<String> categories = sut.getCategories(favorites: []);
        expect(categories.length, 6);
      },
    );

    test(
      'extended',
      () {
        final List<String> categories = sut.getCategories(favorites: [
          Favorite(category: Category.movies, id: 1, name: 'test', url: 'test'),
          Favorite(
              category: Category.tvShows, id: 1, name: 'test', url: 'test'),
        ]);
        expect(categories.length, 7);
      },
    );
  });

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading] and [HomeState] when CategoryChangePressed is added with Categories tab.',
    build: () {
      when(() => homeRepository.fetchGenresByType(type: any(named: 'type')))
          .thenAnswer((_) async => [testGenre]);
      return sut;
    },
    act: (bloc) => bloc.add(CategoryChangePressed(
      selectedTab: 'Categories',
      category: Category.movies,
    )),
    expect: () => [
      HomeLoading(),
      HomeState(genres: [testGenre]),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading] and [HomeState] when CategoryChangePressed is added with tab other than Categories.',
    build: () {
      when(() => homeRepository.fetchTrendingTitles(
          category: any(named: 'category'),
          page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
      return sut;
    },
    act: (bloc) => bloc.add(CategoryChangePressed(
      selectedTab: 'Popular',
      category: Category.movies,
    )),
    expect: () => [
      HomeLoading(),
      HomeState(movies: [testModel]),
    ],
  );

  group('should correctly add titles to sink and obtaint them in [HomeState]',
      () {
    test(
      'with Popular tab',
      () {
        when(() => homeRepository.fetchTrendingTitles(
            category: any(named: 'category'),
            page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
        expectLater(
            sut.onNewListingState,
            emitsInOrder([
              emits(HomeState()),
              emits(HomeState(movies: [testModel], page: null)),
            ]));

        sut.onPageRequestSink.add(
            HomePageModel(page: 1, category: Category.movies, tab: 'Popular'));
      },
    );

    test(
      'with Recommended tab',
      () {
        when(() => homeRepository.fetchRandomFavoriteId(
            category: any(named: 'category'))).thenAnswer((_) async => 1);
        when(() => homeRepository.fetchRecommendedTitles(
            id: any(named: 'id'),
            type: any(named: 'type'),
            page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
        expectLater(
            sut.onNewListingState,
            emitsInOrder([
              emits(HomeState()),
              emits(HomeState(movies: [testModel], page: null)),
            ]));

        sut.onPageRequestSink.add(HomePageModel(
            page: 1, category: Category.movies, tab: 'Recommended'));
      },
    );

    test(
      'with Greatest Hits tab',
      () {
        when(() => homeRepository.fetchTitlesByQuery(
            query: any(named: 'query'),
            category: any(named: 'category'),
            page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
        expectLater(
            sut.onNewListingState,
            emitsInOrder([
              emits(HomeState()),
              emits(HomeState(movies: [testModel], page: null)),
            ]));

        sut.onPageRequestSink.add(HomePageModel(
            page: 1, category: Category.movies, tab: 'Greatest Hits'));
      },
    );

    test(
      'with ${RandomDatesGenerator.randomDecade}s Hits tab',
      () {
        when(() => homeRepository.fetchTitlesByQuery(
            query: any(named: 'query'),
            category: any(named: 'category'),
            page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
        expectLater(
            sut.onNewListingState,
            emitsInOrder([
              emits(HomeState()),
              emits(HomeState(movies: [testModel], page: null)),
            ]));

        sut.onPageRequestSink.add(HomePageModel(
            page: 1,
            category: Category.movies,
            tab: '${RandomDatesGenerator.randomDecade}s Hits'));
      },
    );

    test(
      'with Best of ${RandomDatesGenerator.randomYear} tab',
      () {
        when(() => homeRepository.fetchTitlesByQuery(
            query: any(named: 'query'),
            category: any(named: 'category'),
            page: any(named: 'page'))).thenAnswer((_) async => [testModel]);
        expectLater(
            sut.onNewListingState,
            emitsInOrder([
              emits(HomeState()),
              emits(HomeState(movies: [testModel], page: null)),
            ]));

        sut.onPageRequestSink.add(HomePageModel(
            page: 1,
            category: Category.movies,
            tab: 'Best of ${RandomDatesGenerator.randomYear}'));
      },
    );
  });

  group('should calculate scroll offset', () {
    final List<Map<String, dynamic>> testCases = [
      {'tab': 'Popular', 'screenWidth': 500.0, 'expectedOffset': 0.0},
      {'tab': 'Coming Soon', 'screenWidth': 500.0, 'expectedOffset': 0.0},
      {'tab': 'Recommended', 'screenWidth': 500.0, 'expectedOffset': 100.0},
      {'tab': 'Greatest Hits', 'screenWidth': 500.0, 'expectedOffset': 250.0},
      {
        'tab': '${RandomDatesGenerator.randomDecade}s Hits',
        'screenWidth': 500.0,
        'expectedOffset': (500.0 / 3) * 2
      },
      {
        'tab': 'Best of ${RandomDatesGenerator.randomYear}',
        'screenWidth': 500.0,
        'expectedOffset': 500.0
      },
      {'tab': 'Categories', 'screenWidth': 500.0, 'expectedOffset': 500.0},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['tab']} tab',
        () {
          sut.currentTab = testCase['tab'] as String;
          final double outcome = sut.calculateScrollOffset(
            screenWidth: testCase['screenWidth']! as double,
          );
          expect(outcome, testCase['expectedOffset']);
        },
      );
    }
  });
}
