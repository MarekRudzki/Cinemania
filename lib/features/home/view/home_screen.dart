import 'package:cinemania/features/account/view/account_screen.dart';
import 'package:cinemania/features/movies/view/movies_screen.dart';
import 'package:cinemania/features/tv_shows/view/tv_shows_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageIndex = useState(0);

    final List<Widget> pages = [
      const MoviesScreen(),
      const TVShowsScreen(),
      const AccountScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        body: pages[pageIndex.value],
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: GNav(
          haptic: false,
          selectedIndex: pageIndex.value,
          gap: 10,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          color: const Color.fromARGB(255, 76, 21, 64),
          activeColor: Colors.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          tabs: [
            GButton(
              icon: Icons.abc,
              text: 'Movies',
              onPressed: () {
                pageIndex.value = 0;
              },
              iconSize: 30,
            ),
            GButton(
              icon: Icons.text_snippet,
              text: 'TV Shows',
              onPressed: () {
                pageIndex.value = 1;
              },
              iconSize: 30,
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
              onPressed: () {
                pageIndex.value = 2;
              },
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
