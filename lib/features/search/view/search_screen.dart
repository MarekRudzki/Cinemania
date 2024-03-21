import 'package:cinemania/features/search/view/widgets/search_result.dart';
import 'package:cinemania/features/search/view/widgets/custom_search_bar.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: Theme.of(context).colorScheme.background,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(95),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CustomSearchBar(),
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
                  Theme.of(context).colorScheme.background,
                  Theme.of(context).colorScheme.onBackground,
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
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
