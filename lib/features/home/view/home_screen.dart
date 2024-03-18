import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/home/view/widgets/genres_tiles.dart';
import 'package:cinemania/features/home/view/widgets/home_category_picker.dart';
import 'package:cinemania/features/home/view/widgets/home_titles.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Category category = context.watch<HomeBloc>().currentCategory;
    final String tab = context.watch<HomeBloc>().currentTab;

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
              backgroundColor: Theme.of(context).colorScheme.background,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(75),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FutureBuilder(
                      future: context.read<HomeBloc>().getCategoriesList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return HomeCategoryPicker(
                            categories: snapshot.data!,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        }
                      },
                    ),
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
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              } else {
                if (state.genres == null) {
                  return HomeTitles(
                    category: category,
                    tab: tab,
                  );
                } else {
                  final genres = state.genres!;
                  return GenresTiles(
                    genres: genres,
                    category: category,
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
