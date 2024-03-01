import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPicker extends StatelessWidget {
  final void Function() callback;

  const CategoryPicker({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final currentCategory = context.watch<SearchBloc>().currentCategory;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                const Text(
                  'Movies',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: currentCategory == Category.movies
                        ? Colors.greenAccent
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            onTap: () {
              context
                  .read<SearchBloc>()
                  .add(ChangeCategoryPressed(category: Category.movies));

              context.read<SearchBloc>().add(ResetSearch());
              callback();
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Text(
                    'TV Shows',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: currentCategory == Category.tvShows
                          ? Colors.greenAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<SearchBloc>()
                  .add(ChangeCategoryPressed(category: Category.tvShows));

              context.read<SearchBloc>().add(ResetSearch());
              callback();
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Text(
                    'Cast',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: currentCategory == Category.cast
                          ? Colors.greenAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<SearchBloc>()
                  .add(ChangeCategoryPressed(category: Category.cast));

              context.read<SearchBloc>().add(ResetSearch());
              callback();
            },
          ),
        ],
      ),
    );
  }
}
