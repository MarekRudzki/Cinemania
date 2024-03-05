import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Filmography extends HookWidget {
  final List<PersonFilmography> filmography;

  const Filmography({
    super.key,
    required this.filmography,
  });

  @override
  Widget build(BuildContext context) {
    final currentCategory = useState('movie');
    final controller = useScrollController();

    final movies =
        filmography.where((entity) => entity.mediaType == 'movie').toList();
    final tvShows =
        filmography.where((entity) => entity.mediaType == 'tv').toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Known for:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  currentCategory.value = 'movie';
                  controller.jumpTo(0.0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentCategory.value == 'movie'
                        ? Colors.white
                        : const Color.fromARGB(255, 133, 128, 128),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Movies',
                      style: TextStyle(
                        color: currentCategory.value == 'movie'
                            ? const Color.fromARGB(255, 45, 15, 50)
                            : Colors.white,
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
                  controller.jumpTo(0.0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentCategory.value == 'tv'
                        ? Colors.white
                        : const Color.fromARGB(255, 133, 128, 128),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'TV Shows',
                      style: TextStyle(
                        color: currentCategory.value == 'tv'
                            ? const Color.fromARGB(255, 45, 15, 50)
                            : Colors.white,
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
            height: MediaQuery.sizeOf(context).height * 0.34,
            child: ListView.builder(
              controller: controller,
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
