// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';

class Cast extends StatelessWidget {
  final List<CastMember> cast;
  final Category sourceCategory;
  final int sourceId;

  const Cast({
    super.key,
    required this.cast,
    required this.sourceCategory,
    required this.sourceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cast:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsSuccess) {
                  final String scrollCategory = state.scrollableListCategory;
                  final int scrollIndex = state.scrollableListIndex;

                  return ScrollablePositionedList.builder(
                    initialScrollIndex:
                        scrollCategory == 'cast' && scrollIndex != 0
                            ? state.scrollableListIndex - 1
                            : 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cast.length,
                    itemBuilder: (context, index) {
                      final person = cast[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: GestureDetector(
                          onTap: () {
                            context.read<DetailsBloc>().add(
                                  FetchPersonDataPressed(
                                    id: person.id,
                                    scrollableListCategory: 'movie',
                                    scrollableListIndex: 0,
                                  ),
                                );

                            context.read<DetailsBloc>().add(
                                  AddToHistoryPressed(
                                    id: sourceId,
                                    category: sourceCategory,
                                    scrollableListIndex: index,
                                    scrollableListCategory: 'cast',
                                  ),
                                );

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DetailsScreen(
                                category: Category.cast,
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
                                  photoUrl: person.url,
                                  category: Category.cast,
                                  gender: person.gender,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.33,
                                child: Column(
                                  children: [
                                    Text(
                                      person.name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    if (person.character.isNotEmpty)
                                      Column(
                                        children: [
                                          Text(
                                            'as',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                          Text(
                                            person.character,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
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
