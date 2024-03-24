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
import 'package:cinemania/features/genre/model/genre_repository.dart';
import 'package:cinemania/features/genre/model/models/genre_page_model.dart';

part 'genre_event.dart';
part 'genre_state.dart';

@injectable
class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository genreRepository;

  GenreBloc(this.genreRepository) : super(GenreState()) {
    on<FetchGenrePressed>(_onFetchGenrePressed);

    _onPageRequest.stream
        .flatMap(_fetchCategory)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  Future<void> _onFetchGenrePressed(
    FetchGenrePressed event,
    Emitter<GenreState> emit,
  ) async {
    await genreRepository.fetchGenreTitles(
      genreId: event.genreId,
      page: 1,
      type: event.type == Category.movies ? 'movie' : 'tv',
    );
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController = BehaviorSubject<GenreState>.seeded(
    GenreState(),
  );

  Stream<GenreState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<GenrePageModel>();

  Sink<GenrePageModel> get onPageRequestSink => _onPageRequest.sink;

  Stream<GenreState> _fetchCategory(GenrePageModel categoryPage) async* {
    final lastListingState = _onNewListingStateController.value;

    try {
      List<dynamic> newItems = [];
      if (categoryPage.category == Category.movies) {
        newItems = await genreRepository.fetchGenreTitles(
          genreId: categoryPage.genre!,
          page: categoryPage.page,
          type: 'movie',
        );
      } else {
        newItems = await genreRepository.fetchGenreTitles(
          genreId: categoryPage.genre!,
          page: categoryPage.page,
          type: 'tv',
        );
      }

      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : categoryPage.page + 1;

      if (categoryPage.category == Category.movies) {
        yield GenreState(
          page: nextPageKey,
          movies: [
            ...lastListingState.movies ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      } else {
        yield GenreState(
          page: nextPageKey,
          tvShows: [
            ...lastListingState.tvShows ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      }
    } catch (e) {
      if (categoryPage.category == Category.movies) {
        yield GenreState(
          error: e,
          page: lastListingState.page,
          movies: lastListingState.movies,
        );
      } else {
        yield GenreState(
          error: e,
          page: lastListingState.page,
          tvShows: lastListingState.tvShows,
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
