import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/category/view/category_screen.dart';
import 'package:cinemania/features/category/viewmodel/bloc/category_bloc.dart';
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
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.45,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
        ),
        itemCount: genres.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<DetailsBloc>().add(
                  AddToHistoryPressed(
                    id: sourceId,
                    category: category,
                  ),
                );

            context.read<CategoryBloc>().add(FetchCategoryPressed(
                  query: '${genres[index].id}',
                  type: category,
                ));

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CategoryScreen(
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
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  genres[index].name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
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
