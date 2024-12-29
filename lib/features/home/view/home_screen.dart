// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/home/view/widgets/genres_tiles.dart';
import 'package:cinemania/features/home/view/widgets/home_category_picker.dart';
import 'package:cinemania/features/home/view/widgets/home_titles.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Category category = context.watch<HomeBloc>().currentCategory;
    final String tab = context.watch<HomeBloc>().currentTab;
    final List<Favorite> favorites = context.watch<AccountBloc>().favorites;
    final categoriesList =
        context.read<HomeBloc>().getCategories(favorites: favorites);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return [
              SliverAppBar(
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.surface,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(75),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: HomeCategoryPicker(
                        categories: categoriesList,
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
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.onSurface,
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
      ),
    );
  }
}
