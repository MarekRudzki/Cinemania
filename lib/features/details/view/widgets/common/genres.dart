import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/genre/view/genre_screen.dart';
import 'package:cinemania/features/genre/viewmodel/bloc/genre_bloc.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Genres extends StatelessWidget {
  final List<Genre> genres;
  final Category category;
  final int sourceId;

  const Genres({
    super.key,
    required this.genres,
    required this.category,
    required this.sourceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height *
            (genres.length > 2 ? 0.13 : 0.065),
        width: MediaQuery.sizeOf(context).width * 0.45,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: 1.7,
          ),
          itemCount: genres.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context.read<DetailsBloc>().add(
                    AddToHistoryPressed(
                      id: sourceId,
                      category: category,
                      scrollableListIndex: index,
                      scrollableListCategory: 'genres',
                    ),
                  );

              context.read<GenreBloc>().add(FetchGenrePressed(
                    genreId: genres[index].id,
                    type: category,
                  ));

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GenreScreen(
                    category: category,
                    title: genres[index].name,
                    page: 1,
                    genreId: genres[index].id,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 75, 75),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  genres[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
