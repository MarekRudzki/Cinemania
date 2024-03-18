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
        Center(
          child: Text(
            'Favorites',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).colorScheme.primary,
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
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.secondary,
                        size: currentCategory == 'movies' ? 32 : 28,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    width: 4,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        callback('tv_shows');
                      },
                      child: Icon(
                        MyIcons.tv_show,
                        color: currentCategory == 'tv_shows'
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.secondary,
                        size: currentCategory == 'tv_shows' ? 32 : 28,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    width: 4,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        callback('person');
                      },
                      child: Icon(
                        Icons.person,
                        color: currentCategory == 'person'
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.secondary,
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
