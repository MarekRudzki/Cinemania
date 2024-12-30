// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/config/icons.dart';
import 'package:cinemania/features/search/model/models/search_history_entry.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';

class SearchHistory extends HookWidget {
  final void Function(String text) callback;

  const SearchHistory({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is UserSearches) {
          return Column(
            children: [
              Text(
                'Search History',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                endIndent: width * 0.08,
                indent: width * 0.08,
                color: Colors.grey,
              ),
              Column(
                children: state.searches.reversed
                    .map((e) => SearchHistoryElement(
                          entry: e,
                          callback: (text) => callback(text),
                        ))
                    .toList(),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SearchHistoryElement extends StatelessWidget {
  final SearchHistoryEntry entry;
  final void Function(String text) callback;

  const SearchHistoryElement({
    super.key,
    required this.entry,
    required this.callback,
  });

  IconData showIcon() {
    if (entry.category == Category.movies) {
      return MyIcons.movie;
    } else if (entry.category == Category.tvShows) {
      return MyIcons.tv_show;
    } else {
      return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: GestureDetector(
        onTap: () {
          context
              .read<SearchBloc>()
              .add(ChangeCategoryPressed(category: entry.category));

          context.read<SearchBloc>().add(ResetSearch());
          context.read<SearchBloc>().add(
                SearchPressed(
                  searchQuery: entry.text,
                  category: entry.category,
                ),
              );
          callback(entry.text);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 6,
                ),
                Icon(
                  showIcon(),
                  color: Colors.white,
                  size: 33,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  entry.text.replaceAll('-', ' '),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.touch_app,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
