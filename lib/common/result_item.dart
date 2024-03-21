import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultItem extends StatelessWidget {
  final Category category;
  final int id;
  final int? gender;
  final String name;
  final String url;

  const ResultItem({
    super.key,
    required this.category,
    required this.id,
    this.gender,
    required this.name,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          if (category == Category.movies) {
            context.read<DetailsBloc>().add(
                  FetchMovieDataPressed(
                    id: id,
                    scrollableListCategory: 'cast',
                    scrollableListIndex: 0,
                  ),
                );
          } else if (category == Category.tvShows) {
            context.read<DetailsBloc>().add(
                  FetchTVShowDataPressed(
                    id: id,
                    scrollableListCategory: 'cast',
                    scrollableListIndex: 0,
                  ),
                );
          } else {
            context.read<DetailsBloc>().add(
                  FetchPersonDataPressed(
                    id: id,
                    scrollableListCategory: 'movie',
                    scrollableListIndex: 0,
                  ),
                );
          }
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsScreen(
              category: category,
            ),
          ));
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.37,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: url.contains('No data')
                  ? Stack(
                      children: [
                        Image.asset(
                          context.read<SearchBloc>().getAssetAdress(
                                category: category,
                                gender: gender,
                              ),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 00,
                          left: 0,
                          right: 0,
                          top: MediaQuery.sizeOf(context).height * 0.22,
                          child: Center(
                            child: Text(
                              'NO IMAGE',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : FadeInImage(
                      placeholder: AssetImage(
                        context.read<SearchBloc>().getAssetAdress(
                              category: category,
                              gender: gender,
                            ),
                      ),
                      image: NetworkImage(
                        url,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
                child: Center(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
