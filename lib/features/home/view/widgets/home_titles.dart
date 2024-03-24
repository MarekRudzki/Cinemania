// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/result_item.dart';
import 'package:cinemania/features/home/model/datasources/models/home_page_model.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:cinemania/utils/di.dart';

class HomeTitles extends StatefulWidget {
  final Category category;
  final String tab;

  const HomeTitles({
    super.key,
    required this.category,
    required this.tab,
  });

  @override
  State<HomeTitles> createState() => _HomeTitlesState();
}

class _HomeTitlesState extends State<HomeTitles> {
  final HomeBloc _bloc = getIt<HomeBloc>();

  late StreamSubscription<HomeState> _blocListingStateSubscription;

  final PagingController<int, BasicModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(
        HomePageModel(
          page: pageKey,
          tab: widget.tab,
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
            ? listingState.movies
            : listingState.tvShows,
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
            url: item.imageUrl,
            name: item.name,
          );
        },
      ),
    );
  }
}
