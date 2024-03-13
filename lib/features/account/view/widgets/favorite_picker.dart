import 'package:cinemania/config/icons.dart';
import 'package:flutter/material.dart';

class FavoritePicker extends StatelessWidget {
  final void Function(String category) callback;
  final String currentCategory;

  const FavoritePicker({
    super.key,
    required this.callback,
    required this.currentCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Favorites',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.white,
                width: 0.7,
              ),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        callback('movies');
                      },
                      child: Icon(
                        MyIcons.movie,
                        color: currentCategory == 'movies'
                            ? const Color.fromRGBO(55, 164, 94, 1)
                            : const Color.fromARGB(255, 130, 130, 130),
                        size: currentCategory == 'movies' ? 32 : 28,
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    width: 4,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        callback('tv_shows');
                      },
                      child: Icon(
                        MyIcons.tv_show,
                        color: currentCategory == 'tv_shows'
                            ? const Color.fromRGBO(55, 164, 94, 1)
                            : const Color.fromARGB(255, 130, 130, 130),
                        size: currentCategory == 'tv_shows' ? 32 : 28,
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    width: 4,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        callback('person');
                      },
                      child: Icon(
                        Icons.person,
                        color: currentCategory == 'person'
                            ? const Color.fromRGBO(55, 164, 94, 1)
                            : const Color.fromARGB(255, 130, 130, 130),
                        size: currentCategory == 'person' ? 32 : 28,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
