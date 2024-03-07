import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/config/icons.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/search/view/widgets/result_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        favCategory.value = 'movies';
                      },
                      child: Icon(
                        MyIcons.movie,
                        color: favCategory.value == 'movies'
                            ? Colors.white
                            : const Color.fromARGB(255, 130, 130, 130),
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
                            : const Color.fromARGB(255, 130, 130, 130),
                        size: favCategory.value == 'tv_shows' ? 32 : 28,
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
                        favCategory.value = 'person';
                      },
                      child: Icon(
                        Icons.person,
                        color: favCategory.value == 'person'
                            ? Colors.white
                            : const Color.fromARGB(255, 130, 130, 130),
                        size: favCategory.value == 'person' ? 32 : 28,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        BlocConsumer<AccountBloc, AccountState>(
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
              final favorites = state.favorites!;
              if (favorites.isEmpty) {
                return const Center(
                  child: Text(
                    'No favorites yet. Try add some!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: MediaQuery.sizeOf(context).height * 0.45,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => ResultItem(
                      category: favorites[index].category,
                      id: favorites[index].id,
                      url: favorites[index].url,
                      name: favorites[index].name,
                      gender: favorites[index].gender,
                    ),
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
