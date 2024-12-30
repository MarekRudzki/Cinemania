// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/features/search/view/widgets/custom_search_bar.dart';
import 'package:cinemania/features/search/view/widgets/search_history.dart';
import 'package:cinemania/features/search/view/widgets/search_result.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(
        text: context.watch<SearchBloc>().searchQuery.replaceAll('-', ' '));

    final bool isScrollable =
        context.watch<SearchBloc>().searchQuery.isNotEmpty ||
            context.watch<SearchBloc>().searchQuery != '';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: isScrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return [
              SliverAppBar(
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.surface,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(95),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                          CustomSearchBar(searchController: searchController),
                    ),
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
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.onSurface,
                ],
              ),
            ),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchSuccess) {
                  final String query = context.read<SearchBloc>().searchQuery;
                  return SearchResult(
                    query: query,
                    category: state.category,
                  );
                } else {
                  return SearchHistory(
                    callback: (text) {
                      searchController.text = text.replaceAll('-', ' ');
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
