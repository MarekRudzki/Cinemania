import 'package:cinemania/features/search/viewmodel/bloc/search_bloc.dart';
import 'package:cinemania/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSearchBar extends HookWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final currentCategory = useState(SearchCategory.movies);

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
                        context.read<SearchBloc>().add(
                              SearchPressed(
                                searchQuery: searchController.text.trim(),
                                category: currentCategory.value,
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
                      context.read<SearchBloc>().add(
                            SearchPressed(
                              searchQuery: searchController.text.trim(),
                              category: currentCategory.value,
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
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
                          color: currentCategory.value == SearchCategory.movies
                              ? Colors.greenAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    currentCategory.value = SearchCategory.movies;
                  },
                ),
                InkWell(
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
                          color: currentCategory.value == SearchCategory.tvShows
                              ? Colors.greenAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    currentCategory.value = SearchCategory.tvShows;
                  },
                ),
                InkWell(
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
                          color: currentCategory.value == SearchCategory.cast
                              ? Colors.greenAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    currentCategory.value = SearchCategory.cast;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
