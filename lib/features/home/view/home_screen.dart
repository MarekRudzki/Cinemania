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
              backgroundColor: const Color.fromARGB(255, 45, 15, 50),
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
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
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
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
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
