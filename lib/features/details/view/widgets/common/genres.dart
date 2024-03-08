import 'package:cinemania/common/models/genre.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  final List<Genre> genres;

  const Genres({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.5,
        ),
        itemCount: genres.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 99, 95, 95),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                genres[index].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
