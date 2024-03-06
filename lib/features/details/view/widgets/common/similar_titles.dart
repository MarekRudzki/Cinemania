import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/models/movie_basic.dart';
import 'package:cinemania/common/models/tv_show_basic.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:flutter/material.dart';

class SimilarTitles extends StatelessWidget {
  final List<MovieBasic>? movies;
  final List<TVShowBasic>? tvShows;

  const SimilarTitles({
    super.key,
    this.movies,
    this.tvShows,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You may also like:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.34,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: movies != null ? movies!.length : tvShows!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: EntityPhoto(
                          photoUrl: movies != null
                              ? movies![index].imageUrl
                              : tvShows![index].imageUrl,
                          category: movies != null
                              ? Category.movies
                              : Category.tvShows,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.33,
                        child: Text(
                          movies != null
                              ? movies![index].title
                              : tvShows![index].title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
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
