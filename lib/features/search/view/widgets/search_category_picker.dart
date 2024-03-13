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
                  'Movies',
                  style: TextStyle(
                    color: currentCategory == Category.movies
                        ? Colors.white
                        : const Color.fromARGB(255, 130, 130, 130),
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
                  'TV Shows',
                  style: TextStyle(
                    color: currentCategory == Category.tvShows
                        ? Colors.white
                        : const Color.fromARGB(255, 130, 130, 130),
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
                    'Cast',
                    style: TextStyle(
                      color: currentCategory == Category.cast
                          ? Colors.white
                          : const Color.fromARGB(255, 130, 130, 130),
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
                  ? -1
                  : currentCategory == Category.tvShows
                      ? 0
                      : 1,
              1,
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.22,
              height: 2,
              color: const Color.fromRGBO(55, 164, 94, 1),
            ),
          ),
        ),
      ],
    );
  }
}
