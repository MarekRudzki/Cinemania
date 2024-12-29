// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';

class Filmography extends HookWidget {
  final List<PersonFilmography> filmography;
  final int sourceId;
  final String scrollCategory;
  final int scrollIndex;

  const Filmography({
    super.key,
    required this.filmography,
    required this.sourceId,
    required this.scrollCategory,
    required this.scrollIndex,
  });

  @override
  Widget build(BuildContext context) {
    final currentCategory = useState(scrollCategory);
    final currentIndex = useState(scrollIndex);
    final scrollController = ItemScrollController();

    final movies =
        filmography.where((entity) => entity.mediaType == 'movie').toList();
    final tvShows =
        filmography.where((entity) => entity.mediaType == 'tv').toList();

    int getScrollIndex() {
      int value = 0;
      if (currentCategory.value == 'movie' &&
          scrollCategory == 'movie' &&
          scrollIndex != 0) {
        value = scrollIndex - 1;
      } else if (currentCategory.value == 'tv' &&
          scrollCategory == 'tv' &&
          scrollIndex != 0) {
        value = scrollIndex - 1;
      }
      return value;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Known for:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  currentCategory.value = 'movie';
                  currentIndex.value = 0;
                  scrollController.jumpTo(index: 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentCategory.value == 'movie'
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Movies',
                      style: TextStyle(
                        color: currentCategory.value == 'movie'
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  currentCategory.value = 'tv';
                  currentIndex.value = 0;
                  scrollController.jumpTo(index: 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentCategory.value == 'tv'
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'TV Shows',
                      style: TextStyle(
                        color: currentCategory.value == 'tv'
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 240,
            child: ScrollablePositionedList.builder(
              itemScrollController: scrollController,
              initialScrollIndex: getScrollIndex(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: currentCategory.value == 'movie'
                  ? movies.length
                  : tvShows.length,
              itemBuilder: (context, index) {
                PersonFilmography entity;
                if (currentCategory.value == 'movie') {
                  entity = movies[index];
                } else {
                  entity = tvShows[index];
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: GestureDetector(
                    onTap: () {
                      context.read<DetailsBloc>().add(
                            AddToHistoryPressed(
                              id: sourceId,
                              category: Category.cast,
                              scrollableListIndex: index,
                              scrollableListCategory:
                                  currentCategory.value == 'movie'
                                      ? 'movie'
                                      : 'tv',
                            ),
                          );

                      if (currentCategory.value == 'movie') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailsScreen(
                              category: Category.movies,
                            ),
                          ),
                        );

                        context.read<DetailsBloc>().add(
                              FetchMovieDataPressed(
                                id: entity.id,
                                scrollableListCategory: 'movie',
                                scrollableListIndex: 0,
                              ),
                            );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailsScreen(
                              category: Category.tvShows,
                            ),
                          ),
                        );

                        context.read<DetailsBloc>().add(
                              FetchTVShowDataPressed(
                                id: entity.id,
                                scrollableListCategory: 'tv',
                                scrollableListIndex: index,
                              ),
                            );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: EntityPhoto(
                            photoUrl: entity.url,
                            category: entity.mediaType == 'movie'
                                ? Category.movies
                                : Category.tvShows,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.33,
                          child: Text(
                            entity.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
