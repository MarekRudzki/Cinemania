import 'package:cinemania/config/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Favorites extends HookWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favCategory = useState('movies');

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
        IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      favCategory.value = 'movies';
                    },
                    child: Icon(
                      MyIcons.movie,
                      color: favCategory.value == 'movies'
                          ? Colors.white
                          : Colors.grey,
                      size: favCategory.value == 'movies' ? 32 : 28,
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
                      favCategory.value = 'tv_shows';
                    },
                    child: Icon(
                      MyIcons.tv_show,
                      color: favCategory.value == 'tv_shows'
                          ? Colors.white
                          : Colors.grey,
                      size: favCategory.value == 'tv_shows' ? 32 : 28,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 500,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => const Placeholder(
              fallbackHeight: 50,
              fallbackWidth: 50,
            ),
          ),
        )
      ],
    );
  }
}
