import 'dart:async';

import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/category/model/category_repository.dart';
import 'package:cinemania/features/category/model/models/category_page_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryState()) {
    on<FetchCategoryPressed>(_onFetchCategoryPressed);

    _onPageRequest.stream
        .flatMap(_fetchCategory)
        .listen(_onNewListingStateController.add)
        .addTo(_subscriptions);
  }

  Future<void> _onFetchCategoryPressed(
    FetchCategoryPressed event,
    Emitter<CategoryState> emit,
  ) async {
    final query = '&with_genres=${event.query}&sort_by=vote_count.desc';
    await categoryRepository.fetchCategoryTitles(
      query: query,
      page: 1,
      type: event.type == Category.movies ? 'movie' : 'tv',
    );
  }

  static const _pageSize = 20;

  final _subscriptions = CompositeSubscription();

  final _onNewListingStateController = BehaviorSubject<CategoryState>.seeded(
    CategoryState(),
  );

  Stream<CategoryState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<CategoryPageModel>();

  Sink<CategoryPageModel> get onPageRequestSink => _onPageRequest.sink;

  Stream<CategoryState> _fetchCategory(CategoryPageModel categoryPage) async* {
    final lastListingState = _onNewListingStateController.value;

    try {
      List<dynamic> newItems = [];
      if (categoryPage.category == Category.movies) {
        newItems = await categoryRepository.fetchCategoryTitles(
          query: '&with_genres=${categoryPage.genre}&sort_by=vote_count.desc',
          page: categoryPage.page,
          type: 'movie',
        );
      } else {
        newItems = await categoryRepository.fetchCategoryTitles(
          query: '&with_genres=${categoryPage.genre}&sort_by=vote_count.desc',
          page: categoryPage.page,
          type: 'tv',
        );
      }

      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : categoryPage.page + 1;

      if (categoryPage.category == Category.movies) {
        yield CategoryState(
          page: nextPageKey,
          movies: [
            ...lastListingState.movies ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      } else {
        yield CategoryState(
          page: nextPageKey,
          tvShows: [
            ...lastListingState.tvShows ?? [],
            ...newItems as List<BasicModel>,
          ],
        );
      }
    } catch (e) {
      if (categoryPage.category == Category.movies) {
        yield CategoryState(
          error: e,
          page: lastListingState.page,
          movies: lastListingState.movies,
        );
      } else {
        yield CategoryState(
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
