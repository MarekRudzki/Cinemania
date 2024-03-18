import 'dart:async';

import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/search/model/models/search_page_model.dart';
import 'package:cinemania/common/result_item.dart';
import 'package:cinemania/features/search/viewmodel/pagination/pagination_bloc.dart';
import 'package:cinemania/utils/di.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchResult extends StatefulWidget {
  final String query;
  final Category category;

  const SearchResult({
    super.key,
    required this.query,
    required this.category,
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final PaginationBloc _bloc = getIt<PaginationBloc>();

  late StreamSubscription<PaginationState> _blocListingStateSubscription;

  final PagingController<int, BasicModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(
        SearchPageModel(
          page: pageKey,
          query: widget.query,
          category: widget.category,
        ),
      );
    });

    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((listingState) {
      _pagingController.value = PagingState(
        nextPageKey: listingState.page,
        error: listingState.error,
        itemList: widget.category == Category.movies
            ? listingState.searchedMovies
            : widget.category == Category.tvShows
                ? listingState.searchedTVShows
                : listingState.searchedCast,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _blocListingStateSubscription.cancel();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      physics: const NeverScrollableScrollPhysics(),
      showNewPageProgressIndicatorAsGridChild: false,
      pagingController: _pagingController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: MediaQuery.sizeOf(context).height * 0.45,
      ),
      builderDelegate: PagedChildBuilderDelegate<BasicModel>(
        firstPageProgressIndicatorBuilder: (context) => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        newPageProgressIndicatorBuilder: (context) => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            Text(
              'No items found.',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        itemBuilder: (context, item, i) {
          return ResultItem(
            category: widget.category,
            id: item.id,
            gender: item.gender,
            url: item.imageUrl,
            name: item.name,
          );
        },
      ),
    );
  }
}
