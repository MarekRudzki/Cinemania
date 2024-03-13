import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeCategoryPicker extends HookWidget {
  final void Function() callback;

  HomeCategoryPicker({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> categories = context.read<HomeBloc>().categories;
    final selectedCategory = useState(categories[0]);
    final currentCategory = Category.movies;

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
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 15),
                child: GestureDetector(
                  onTap: () {
                    selectedCategory.value = categories[index];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: selectedCategory.value == categories[index]
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // animationController.animateTo(0.toDouble());
                      // context
                      //     .read<SearchBloc>()
                      //     .add(ChangeCategoryPressed(category: Category.movies));

                      // context.read<SearchBloc>().add(ResetSearch());
                      // callback();
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
                      // animationController.animateTo(1.toDouble());
                      // context
                      //     .read<SearchBloc>()
                      //     .add(ChangeCategoryPressed(category: Category.tvShows));

                      // context.read<SearchBloc>().add(ResetSearch());
                      // callback();
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
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment(
                  currentCategory == Category.movies ? -1 : 1,
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
        ),
      ],
    );
  }
}
