// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';
import 'package:cinemania/features/home/model/datasources/models/home_page_model.dart';
import 'package:cinemania/features/home/model/home_repository.dart';
import 'package:cinemania/features/home/viewmodel/random_dates_generator.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeState()) {
    _onPageRequest.stream
        .flatMap(_fetchSearchResult)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);

    on<CategoryChangePressed>(_onCategoryChangePressed);
  }

  Category currentCategory = Category.movies;
  String currentTab = 'Popular';

  List<String> getCategories({
    required List<Favorite> favorites,
  }) {
    final List<String> categories = [
      'Popular',
      'Coming Soon',
      'Greatest Hits',
      '${RandomDatesGenerator.randomDecade}s Hits',
      'Best of ${RandomDatesGenerator.randomYear}',
      'Categories',
    ];

    bool hasFavMovie = false;
    bool hasFavTvShow = false;

    for (final favorite in favorites) {
      if (favorite.category == Category.movies) {
        hasFavMovie = true;
      } else if (favorite.category == Category.tvShows) {
        hasFavTvShow = true;
      }
    }

    if (hasFavMovie && hasFavTvShow) {
      categories.insert(2, 'Recommended');
    }

    return categories;
  }

  Future<void> _onCategoryChangePressed(
    CategoryChangePressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    currentCategory = event.category;
    currentTab = event.selectedTab;
    if (currentTab != 'Categories') {
      final newItems = await fetchTitles(
          tab: event.selectedTab, category: event.category, page: 1);
      if (event.category == Category.movies) {
        emit(HomeState(movies: newItems as List<BasicModel>));
      } else {
        emit(HomeState(tvShows: newItems as List<BasicModel>));
      }
    } else {
      final genres = await homeRepository.fetchGenresByType(
          type: event.category == Category.movies ? 'movie' : 'tv');
      emit(HomeState(genres: genres));
    }
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController = BehaviorSubject<HomeState>.seeded(
    HomeState(),
  );

  Stream<HomeState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<HomePageModel>();

  Sink<HomePageModel> get onPageRequestSink => _onPageRequest.sink;

  Stream<HomeState> _fetchSearchResult(HomePageModel homePageModel) async* {
    final lastListingState = _onNewListingStateController.value;

    try {
      final List<dynamic> newItems = await fetchTitles(
        tab: homePageModel.tab,
        category: homePageModel.category,
        page: homePageModel.page,
      );

      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : homePageModel.page + 1;

      if (homePageModel.category == Category.movies) {
        yield HomeState(
          page: nextPageKey,
          movies: [
            ...lastListingState.movies ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      } else {
        yield HomeState(
          page: nextPageKey,
          tvShows: [
            ...lastListingState.tvShows ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      }
    } catch (e) {
      if (homePageModel.category == Category.movies) {
        yield HomeState(
          error: e,
          page: lastListingState.page,
          movies: lastListingState.movies,
        );
      } else {
        yield HomeState(
          error: e,
          page: lastListingState.page,
          tvShows: lastListingState.tvShows,
        );
      }
    }
  }

  Future<List<dynamic>> fetchTitles({
    required String tab,
    required Category category,
    required int page,
  }) async {
    List<dynamic> newItems = [];
    final randomYear = RandomDatesGenerator.randomYear;
    final randomDecade = RandomDatesGenerator.randomDecade;

    String categoryAsString;
    if (category == Category.movies) {
      categoryAsString = 'movie';
    } else {
      categoryAsString = 'tv';
    }

    if (tab == 'Popular') {
      newItems = await homeRepository.fetchTrendingTitles(
        category: categoryAsString,
        page: page,
      );
    } else if (tab == 'Coming Soon') {
      final DateTime now = DateTime.now();
      final String today = DateTime(now.year, now.month, now.day + 1)
          .toString()
          .substring(0, 10);
      final String monthFromToday =
          DateTime(now.year, now.month + 1, now.day + 1)
              .toString()
              .substring(0, 10);

      newItems = await homeRepository.fetchTitlesByQuery(
        category: categoryAsString,
        query: category == Category.movies
            ? 'primary_release_date.gte=$today&primary_release_date.lte=$monthFromToday'
            : 'first_air_date.gte=$today&first_air_date.lte=$monthFromToday',
        page: page,
      );
    } else if (tab == 'Recommended') {
      final int titleId = await homeRepository.fetchRandomFavoriteId(
        category: category.toString(),
      );

      newItems = await homeRepository.fetchRecommendedTitles(
        id: titleId,
        type: categoryAsString,
        page: page,
      );
    } else if (tab == 'Greatest Hits') {
      newItems = await homeRepository.fetchTitlesByQuery(
        category: categoryAsString,
        query: category == Category.movies
            ? 'sort_by=revenue.desc'
            : 'sort_by=vote_count.desc',
        page: page,
      );
    } else if (tab.contains('0s Hits')) {
      final String firstDayOfDecade =
          DateTime(randomDecade).toString().substring(0, 10);
      final String lastDayOfDecade =
          DateTime(randomDecade + 9, 12, 31).toString().substring(0, 10);

      newItems = await homeRepository.fetchTitlesByQuery(
        category: categoryAsString,
        query: category == Category.movies
            ? 'primary_release_date.gte=$firstDayOfDecade&primary_release_date.lte=$lastDayOfDecade'
            : 'first_air_date.gte=$firstDayOfDecade&first_air_date.lte=$lastDayOfDecade',
        page: page,
      );
    } else if (tab.contains('Best of')) {
      final String firstDayOfYear =
          DateTime(randomYear).toString().substring(0, 10);
      final String lastDayOfYear =
          DateTime(randomYear, 12, 31).toString().substring(0, 10);

      newItems = await homeRepository.fetchTitlesByQuery(
        category: categoryAsString,
        query: category == Category.movies
            ? 'primary_release_date.gte=$firstDayOfYear&primary_release_date.lte=$lastDayOfYear'
            : 'first_air_date.gte=$firstDayOfYear&first_air_date.lte=$lastDayOfYear',
        page: page,
      );
    }
    return newItems;
  }

  void dispose() {
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }

  double calculateScrollOffset({
    required double screenWidth,
  }) {
    if (currentTab == 'Popular' || currentTab == 'Coming Soon') {
      return 0.0;
    } else if (currentTab == 'Recommended') {
      return screenWidth / 5;
    } else if (currentTab == 'Greatest Hits') {
      return screenWidth / 2;
    } else if (currentTab.contains('s Hits')) {
      return (screenWidth / 3) * 2;
    } else {
      return screenWidth;
    }
  }
}
