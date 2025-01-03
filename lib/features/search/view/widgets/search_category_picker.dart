// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';

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
          child: SizedBox(
            height: 33,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      animationController.animateTo(0.toDouble());
                      context.read<SearchBloc>().add(
                          ChangeCategoryPressed(category: Category.movies));

                      context.read<SearchBloc>().add(ResetSearch());
                      callback();
                      context.read<SearchBloc>().add(GetUserSearchesPressed());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Center(
                        child: Text(
                          'Movie',
                          style: TextStyle(
                            color: currentCategory == Category.movies
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontSize:
                                currentCategory == Category.movies ? 15 : 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      animationController.animateTo(1.toDouble());
                      context.read<SearchBloc>().add(
                          ChangeCategoryPressed(category: Category.tvShows));

                      context.read<SearchBloc>().add(ResetSearch());
                      callback();
                      context.read<SearchBloc>().add(GetUserSearchesPressed());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Center(
                        child: Text(
                          'TV Show',
                          style: TextStyle(
                            color: currentCategory == Category.tvShows
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontSize:
                                currentCategory == Category.tvShows ? 15 : 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      animationController.animateTo(2.toDouble());
                      context
                          .read<SearchBloc>()
                          .add(ChangeCategoryPressed(category: Category.cast));

                      context.read<SearchBloc>().add(ResetSearch());
                      callback();
                      context.read<SearchBloc>().add(GetUserSearchesPressed());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Center(
                        child: Text(
                          'Person',
                          style: TextStyle(
                            color: currentCategory == Category.cast
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontSize:
                                currentCategory == Category.cast ? 15 : 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
