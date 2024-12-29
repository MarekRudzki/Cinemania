// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Project imports:
import 'package:cinemania/common/no_network_screen.dart';
import 'package:cinemania/features/account/view/account_screen.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/home/view/home_screen.dart';
import 'package:cinemania/features/main/viewmodel/internet_connection_provider.dart';
import 'package:cinemania/features/search/view/search_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _hasInternet =
        context.watch<InternetConnectionProvider>().hasInternet;

    useEffect(() {
      context.read<AccountBloc>().saveUsernameFromFirebaseToHive();
      context.read<AccountBloc>().add(UserFavoritesRequested());
      return null;
    }, []);

    final pageIndex = useState(0);

    final List<Widget> pages = [
      const HomeScreen(),
      const SearchScreen(),
      const AccountScreen(),
    ];

    return PopScope(
      canPop: false,
      child: _hasInternet
          ? SafeArea(
              child: Scaffold(
                body: pages[pageIndex.value],
                bottomNavigationBar: GNav(
                  haptic: false,
                  selectedIndex: pageIndex.value,
                  gap: 10,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  color: Theme.of(context).colorScheme.tertiary,
                  activeColor: const Color.fromRGBO(55, 164, 94, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      onPressed: () {
                        pageIndex.value = 0;
                      },
                      iconSize: 30,
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
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
            )
          : const NoNetworkScreen(),
    );
  }
}
