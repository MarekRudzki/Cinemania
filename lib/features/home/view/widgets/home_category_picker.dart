// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';

class HomeCategoryPicker extends HookWidget {
  final List<String> categories;

  HomeCategoryPicker({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<HomeBloc>().currentTab;
    final selectedCategory = context.watch<HomeBloc>().currentCategory;

    final scrollController = useScrollController(
      initialScrollOffset: context.read<HomeBloc>().calculateScrollOffset(
            screenWidth: MediaQuery.sizeOf(context).width,
          ),
    );

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              controller: scrollController,
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 15),
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeBloc>().add(
                          CategoryChangePressed(
                            selectedTab: categories[index],
                            category: selectedCategory,
                          ),
                        );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: selectedTab == categories[index]
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.scrim,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      animationController.animateTo(0.toDouble());
                      context.read<HomeBloc>().add(
                            CategoryChangePressed(
                              selectedTab: selectedTab,
                              category: Category.movies,
                            ),
                          );
                    },
                    child: Text(
                      'Movies',
                      style: TextStyle(
                        color: selectedCategory == Category.movies
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: selectedCategory == Category.movies ? 15 : 14,
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      animationController.animateTo(1.toDouble());
                      context.read<HomeBloc>().add(CategoryChangePressed(
                            selectedTab: selectedTab,
                            category: Category.tvShows,
                          ));
                    },
                    child: Text(
                      'TV Shows',
                      style: TextStyle(
                        color: selectedCategory == Category.tvShows
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        fontSize:
                            selectedCategory == Category.tvShows ? 15 : 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.15,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment(
                  selectedCategory == Category.movies ? -1 : 1,
                  1,
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.33,
                  height: 2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }
}
