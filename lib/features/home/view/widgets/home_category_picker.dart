import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    return Column(
      //TODO category picker scrolling issue
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
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
                          ? const Color.fromRGBO(55, 164, 94, 1)
                          : Colors.grey.shade600,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            color: Colors.white,
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
                            ? Colors.white
                            : const Color.fromARGB(255, 130, 130, 130),
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
                            ? Colors.white
                            : const Color.fromARGB(255, 130, 130, 130),
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
                  color: const Color.fromRGBO(55, 164, 94, 1),
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
