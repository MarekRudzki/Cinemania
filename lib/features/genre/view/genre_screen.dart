import 'dart:async';

import 'package:cinemania/common/back_button_fun.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/common/result_item.dart';
import 'package:cinemania/features/genre/model/models/genre_page_model.dart';
import 'package:cinemania/features/genre/viewmodel/bloc/genre_bloc.dart';
import 'package:cinemania/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GenreScreen extends StatefulWidget {
  final Category category;
  final String title;
  final int? genreId;
  final int page;

  const GenreScreen({
    super.key,
    required this.category,
    required this.title,
    this.genreId,
    required this.page,
  });

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final GenreBloc _bloc = getIt<GenreBloc>();

  late StreamSubscription<GenreState> _blocListingStateSubscription;

  final PagingController<int, BasicModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(
        GenrePageModel(
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
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          // ignore: deprecated_member_use
          body: WillPopScope(
            onWillPop: () async {
              backButtonFun(context: context);
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return [
                  SliverAppBar(
                    elevation: 5,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    forceElevated: innerBoxIsScrolled,
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      widget.title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.onBackground,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
