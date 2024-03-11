import 'dart:async';

import 'package:cinemania/common/back_button_fun.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/common/result_item.dart';
import 'package:cinemania/features/category/model/models/category_page_model.dart';
import 'package:cinemania/features/category/viewmodel/bloc/category_bloc.dart';
import 'package:cinemania/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final String title;
  final int? genreId;
  final int page;

  const CategoryScreen({
    super.key,
    required this.category,
    required this.title,
    this.genreId,
    required this.page,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryBloc _bloc = getIt<CategoryBloc>();

  late StreamSubscription<CategoryState> _blocListingStateSubscription;

  final PagingController<int, BasicModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(
        CategoryPageModel(
          page: pageKey,
          genre: widget.genreId,
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
    return SafeArea(
      child: Scaffold(
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            backButtonFun(context: context);
            return true;
          },
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return [
                SliverAppBar(
                  elevation: 5,
                  backgroundColor: const Color.fromARGB(255, 45, 15, 50),
                  forceElevated: innerBoxIsScrolled,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 45, 15, 50),
                    Color.fromARGB(255, 87, 25, 98),
                  ],
                ),
              ),
              child: PagedGridView(
                showNewPageProgressIndicatorAsGridChild: false,
                pagingController: _pagingController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQuery.sizeOf(context).height * 0.45,
                ),
                builderDelegate: PagedChildBuilderDelegate<BasicModel>(
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
                      category: widget.category,
                      id: item.id,
                      gender: item.gender,
                      url: item.imageUrl,
                      name: item.name,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
