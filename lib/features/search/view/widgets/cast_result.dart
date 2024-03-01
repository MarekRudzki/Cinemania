import 'dart:async';

import 'package:cinemania/common/models/person_basic.dart';
import 'package:cinemania/features/search/model/models/search_page_model.dart';
import 'package:cinemania/features/search/view/widgets/result_item.dart';
import 'package:cinemania/features/search/viewmodel/pagination/pagination_bloc.dart';
import 'package:cinemania/utils/di.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CastResult extends StatefulWidget {
  final String query;

  const CastResult({
    super.key,
    required this.query,
  });

  @override
  State<CastResult> createState() => _CastResultState();
}

class _CastResultState extends State<CastResult> {
  final PaginationBloc _bloc = getIt<PaginationBloc>();

  late StreamSubscription<PaginationState> _blocListingStateSubscription;

  final PagingController<int, PersonBasic> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(
        SearchPageModel(
          page: pageKey,
          query: widget.query,
          category: Category.cast,
        ),
      );
    });

    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((listingState) {
      _pagingController.value = PagingState(
        nextPageKey: listingState.page,
        error: listingState.error,
        itemList: listingState.searchedCast,
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
      showNewPageProgressIndicatorAsGridChild: false,
      pagingController: _pagingController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: MediaQuery.sizeOf(context).height * 0.45,
      ),
      builderDelegate: PagedChildBuilderDelegate<PersonBasic>(
        firstPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            const Text(
              'No items found.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        itemBuilder: (context, item, i) {
          return ResultItem(
            category: Category.cast,
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
