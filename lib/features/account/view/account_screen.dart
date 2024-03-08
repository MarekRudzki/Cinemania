import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/features/account/view/widgets/change_password.dart';
import 'package:cinemania/features/account/view/widgets/change_username.dart';
import 'package:cinemania/features/account/view/widgets/delete_account.dart';
import 'package:cinemania/features/account/view/widgets/favorite_picker.dart';
import 'package:cinemania/features/account/view/widgets/logout.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/common/result_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(UserFavoritesRequested());
    final favCategory = useState('movies');

    final passwordChangeVisible =
        context.read<AccountBloc>().passwordChangePossible();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return [
            SliverAppBar(
              elevation: 5,
              backgroundColor: const Color.fromARGB(255, 45, 15, 50),
              forceElevated: innerBoxIsScrolled,
              centerTitle: true,
              title: Text(
                context.watch<AccountBloc>().getUsername(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              actions: [
                PopupMenuButton(
                  iconColor: Colors.white,
                  color: const Color.fromARGB(255, 87, 25, 98),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(child: ChangeUsername()),
                      if (passwordChangeVisible)
                        const PopupMenuItem(child: ChangePassword()),
                      const PopupMenuItem(child: DeleteAccount()),
                      const PopupMenuItem(child: Logout()),
                    ];
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.sizeOf(context).height * 0.15),
                child: FavoritePicker(
                  callback: (category) {
                    favCategory.value = category;
                  },
                  currentCategory: favCategory.value,
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color.fromARGB(255, 45, 15, 50),
                Color.fromARGB(255, 87, 25, 98),
              ],
            ),
          ),
          child: BlocConsumer<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccountError) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackbar.showSnackBar(
                    message: state.errorMessage,
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AccountSuccess) {
                context
                    .read<AccountBloc>()
                    .addListToLocalFavorites(allfavorites: state.favorites!);
                final currentCategoryFavorites =
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Try add some!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: GridView.builder(
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
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
