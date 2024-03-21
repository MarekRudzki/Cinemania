import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchCategoryPicker extends HookWidget {
  final void Function() callback;

  SearchCategoryPicker({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final currentCategory = context.watch<SearchBloc>().currentCategory;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  animationController.animateTo(0.toDouble());
                  context
                      .read<SearchBloc>()
                      .add(ChangeCategoryPressed(category: Category.movies));

                  context.read<SearchBloc>().add(ResetSearch());
                  callback();
                },
                child: Text(
                  'Movie',
                  style: TextStyle(
                    color: currentCategory == Category.movies
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: currentCategory == Category.movies ? 15 : 14,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  animationController.animateTo(1.toDouble());
                  context
                      .read<SearchBloc>()
                      .add(ChangeCategoryPressed(category: Category.tvShows));

                  context.read<SearchBloc>().add(ResetSearch());
                  callback();
                },
                child: Text(
                  'TV Show',
                  style: TextStyle(
                    color: currentCategory == Category.tvShows
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: currentCategory == Category.tvShows ? 15 : 14,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  animationController.animateTo(2.toDouble());
                  context
                      .read<SearchBloc>()
                      .add(ChangeCategoryPressed(category: Category.cast));

                  context.read<SearchBloc>().add(ResetSearch());
                  callback();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Person',
                    style: TextStyle(
                      color: currentCategory == Category.cast
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      fontSize: currentCategory == Category.cast ? 15 : 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment(
              currentCategory == Category.movies
                  ? -0.95
                  : currentCategory == Category.tvShows
                      ? -0.05
                      : 0.92,
              1,
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.22,
              height: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
