// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';

class SimilarTitles extends StatelessWidget {
  final List<BasicModel>? movies;
  final List<BasicModel>? tvShows;
  final int sourceId;

  const SimilarTitles({
    super.key,
    this.movies,
    this.tvShows,
    required this.sourceId,
  });

  @override
  Widget build(BuildContext context) {
    final Category category =
        movies != null ? Category.movies : Category.tvShows;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You may also like:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 240,
            child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsSuccess) {
                  final String scrollCategory = state.scrollableListCategory;
                  final int scrollIndex = state.scrollableListIndex;

                  return ScrollablePositionedList.builder(
                    initialScrollIndex:
                        scrollCategory == 'similar' && scrollIndex != 0
                            ? state.scrollableListIndex - 1
                            : 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: category == Category.movies
                        ? movies!.length
                        : tvShows!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: GestureDetector(
                          onTap: () {
                            if (category == Category.movies) {
                              context.read<DetailsBloc>().add(
                                    FetchMovieDataPressed(
                                      id: movies![index].id,
                                      scrollableListCategory: 'similar',
                                      scrollableListIndex: 0,
                                    ),
                                  );
                            } else {
                              context.read<DetailsBloc>().add(
                                    FetchTVShowDataPressed(
                                      id: tvShows![index].id,
                                      scrollableListCategory: 'similar',
                                      scrollableListIndex: 0,
                                    ),
                                  );
                            }
                            context.read<DetailsBloc>().add(
                                  AddToHistoryPressed(
                                    id: sourceId,
                                    category: category,
                                    scrollableListIndex: index,
                                    scrollableListCategory: 'similar',
                                  ),
                                );

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                category: category,
                              ),
                            ));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                child: EntityPhoto(
                                  photoUrl: category == Category.movies
                                      ? movies![index].imageUrl
                                      : tvShows![index].imageUrl,
                                  category: category,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.33,
                                child: Text(
                                  category == Category.movies
                                      ? movies![index].name
                                      : tvShows![index].name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
