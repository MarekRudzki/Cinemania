import 'package:cinemania/features/search/view/widgets/category_picker.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSearchBar extends HookWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController =
        useTextEditingController(text: context.watch<SearchBloc>().searchQuery);
    final currentCategory = context.watch<SearchBloc>().currentCategory;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 213, 213),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 87, 46, 95),
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        context.read<SearchBloc>().add(
                              SearchPressed(
                                searchQuery: searchController.text.trim(),
                                category: currentCategory,
                              ),
                            );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 213, 213),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<SearchBloc>().add(
                            SearchPressed(
                              searchQuery: searchController.text.trim(),
                              category: currentCategory,
                            ),
                          );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 45, 15, 50),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CategoryPicker(
            callback: () {
              searchController.clear();
            },
          ),
        ],
      ),
    );
  }
}
