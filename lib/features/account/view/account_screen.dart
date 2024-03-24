// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/result_item.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/account/view/widgets/change_password.dart';
import 'package:cinemania/features/account/view/widgets/change_username.dart';
import 'package:cinemania/features/account/view/widgets/delete_account.dart';
import 'package:cinemania/features/account/view/widgets/favorite_picker.dart';
import 'package:cinemania/features/account/view/widgets/logout.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favCategory = useState('movies');
    final scrollController = useScrollController();

    context
        .watch<AccountBloc>()
        .checkIfCategoryIsScrollable(category: favCategory.value);
    final bool isScrollable = context.watch<AccountBloc>().isCategoryScrollable;

    final passwordChangeVisible =
        context.read<AccountBloc>().passwordChangePossible();

    final int categoryLength = context
        .read<AccountBloc>()
        .getCurrentCategoryLength(category: favCategory.value);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          controller: scrollController,
          physics: isScrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            if (categoryLength == 2) {
              scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }

            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.background,
                centerTitle: true,
                title: Text(
                  context.watch<AccountBloc>().getUsername(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                ),
                actions: [
                  PopupMenuButton(
                    iconColor: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.onBackground,
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: ChangeUsername(),
                          enabled: false,
                        ),
                        if (passwordChangeVisible)
                          const PopupMenuItem(
                            child: ChangePassword(),
                            enabled: false,
                          ),
                        const PopupMenuItem(
                          child: DeleteAccount(),
                          enabled: false,
                        ),
                        const PopupMenuItem(
                          child: Logout(),
                          enabled: false,
                        ),
                      ];
                    },
                    onCanceled: () {
                      context.read<AccountBloc>().add(UserFavoritesRequested());
                    },
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(MediaQuery.sizeOf(context).height * 0.15),
                  child: FavoritePicker(
                    callback: (category) {
                      favCategory.value = category;
                      context.read<AccountBloc>().add(UserFavoritesRequested());
                    },
                    currentCategory: favCategory.value,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.background,
                  Theme.of(context).colorScheme.onBackground,
                ],
              ),
            ),
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AccountSuccess) {
                  List<Favorite> currentCategoryFavorites =
                      context.read<AccountBloc>().pickFavoritesByCategory(
                            favorites: state.favorites!,
                            currentCategory: favCategory.value,
                          );
                  if (currentCategoryFavorites.isEmpty) {
                    final noCategoryText = context
                        .read<AccountBloc>()
                        .getNoFavoriteText(category: favCategory.value);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don\'t have any favorite $noCategoryText yet!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Try add some!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  } else {
                    currentCategoryFavorites =
                        currentCategoryFavorites.reversed.toList();
                    return GridView.builder(
                      physics: isScrollable
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:
                            MediaQuery.sizeOf(context).height * 0.45,
                      ),
                      itemCount: currentCategoryFavorites.length,
                      itemBuilder: (context, index) => ResultItem(
                        category: currentCategoryFavorites[index].category,
                        id: currentCategoryFavorites[index].id,
                        url: currentCategoryFavorites[index].url,
                        name: currentCategoryFavorites[index].name,
                        gender: currentCategoryFavorites[index].gender,
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
