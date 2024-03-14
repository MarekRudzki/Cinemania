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

    return Scaffold(
      body: NestedScrollView(
        physics: isScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
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
    );
  }
}
