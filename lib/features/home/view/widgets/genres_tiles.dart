import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/genre/view/genre_screen.dart';
import 'package:cinemania/features/genre/viewmodel/bloc/genre_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenresTiles extends StatelessWidget {
  final Category category;
  final List<Genre> genres;

  const GenresTiles({
    super.key,
    required this.genres,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: genres.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
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
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 0.5,
              ),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 24, 26, 24),
                  Color.fromARGB(255, 75, 77, 75),
                ],
              ),
            ),
            child: Center(
              child: Text(
                genres[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
