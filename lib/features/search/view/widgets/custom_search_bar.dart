// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/features/search/view/widgets/search_category_picker.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';

class CustomSearchBar extends HookWidget {
  final TextEditingController searchController;

  const CustomSearchBar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final currentCategory = context.watch<SearchBloc>().currentCategory;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SearchCategoryPicker(
            callback: () {
              searchController.clear();
            },
          ),
          const SizedBox(height: 10),
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
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 2,
                      bottom: 2,
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      textAlign: TextAlign.left,
                      cursorColor: Theme.of(context).colorScheme.surface,
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 14),
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(150),
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                            context.read<SearchBloc>().add(ResetSearch());
                            context
                                .read<SearchBloc>()
                                .add(GetUserSearchesPressed());
                          },
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
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
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
