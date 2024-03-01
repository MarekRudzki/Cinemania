import 'dart:async';

import 'package:cinemania/common/models/movie_basic.dart';
import 'package:cinemania/common/models/person_basic.dart';
import 'package:cinemania/common/models/tv_show_basic.dart';
import 'package:cinemania/features/search/model/models/search_page_model.dart';
import 'package:cinemania/features/search/model/search_repository.dart';
import 'package:cinemania/common/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

@injectable
class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final SearchRepository searchRepository;

  PaginationBloc(this.searchRepository) : super(PaginationState()) {
    _onPageRequest.stream
        .flatMap(_fetchSearchResult)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController = BehaviorSubject<PaginationState>.seeded(
    PaginationState(),
  );

  Stream<PaginationState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<SearchPageModel>();

  Sink<SearchPageModel> get onPageRequestSink => _onPageRequest.sink;

  Stream<PaginationState> _fetchSearchResult(
      SearchPageModel searchPage) async* {
    final lastListingState = _onNewListingStateController.value;

    try {
      List<dynamic> newItems = [];
      if (searchPage.category == Category.movies) {
        newItems = await searchRepository.fetchMovies(
          query: searchPage.query,
          page: searchPage.page,
        );
      } else if (searchPage.category == Category.tvShows) {
        newItems = await searchRepository.fetchTvShows(
          query: searchPage.query,
          page: searchPage.page,
        );
      } else {
        newItems = await searchRepository.fetchCast(
          query: searchPage.query,
          page: searchPage.page,
        );
      }

      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : searchPage.page + 1;

      if (searchPage.category == Category.movies) {
        yield PaginationState(
          page: nextPageKey,
          searchedMovies: [
            ...lastListingState.searchedMovies ?? [],
            ...newItems as List<MovieBasic>,
          ],
        );
      } else if (searchPage.category == Category.tvShows) {
        yield PaginationState(
          page: nextPageKey,
          searchedTVShows: [
            ...lastListingState.searchedTVShows ?? [],
            ...newItems as List<TVShowBasic>,
          ],
        );
      } else {
        yield PaginationState(
          page: nextPageKey,
          searchedCast: [
            ...lastListingState.searchedCast ?? [],
            ...newItems as List<PersonBasic>,
          ],
        );
      }
    } catch (e) {
      if (searchPage.category == Category.movies) {
        yield PaginationState(
          error: e,
          page: lastListingState.page,
          searchedMovies: lastListingState.searchedMovies,
        );
      } else if (searchPage.category == Category.tvShows) {
        yield PaginationState(
          error: e,
          page: lastListingState.page,
          searchedTVShows: lastListingState.searchedTVShows,
        );
      } else {
        yield PaginationState(
          error: e,
          page: lastListingState.page,
          searchedCast: lastListingState.searchedCast,
        );
      }
    }
  }

  void dispose() {
    _onNewListingStateController.close();
    _subscriptions.dispose();
    _onPageRequest.close();
  }
}
