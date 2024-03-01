import 'package:cinemania/features/search/view/widgets/cast_result.dart';
import 'package:cinemania/features/search/view/widgets/custom_search_bar.dart';
import 'package:cinemania/features/search/view/widgets/movies_result.dart';
import 'package:cinemania/features/search/view/widgets/tv_shows_result.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        const CustomSearchBar(),
                        Divider(
                          endIndent: 30,
                          indent: 30,
                          color: Colors.grey.shade600,
                          thickness: 2,
                        ),
                      ],
                    ),
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
              if (state is SearchSuccess) {
                final String query = context.read<SearchBloc>().searchQuery;
                if (state.category == Category.movies) {
                  return MoviesResult(query: query);
                } else if (state.category == Category.tvShows) {
                  return TVShowsResult(query: query);
                } else {
                  return CastResult(query: query);
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
