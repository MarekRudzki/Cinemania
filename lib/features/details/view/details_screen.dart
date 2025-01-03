// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/back_button_fun.dart';
import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/common/no_network_screen.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_details.dart';
import 'package:cinemania/features/details/view/widgets/person/person_details.dart';
import 'package:cinemania/features/details/view/widgets/tv_show/tv_show_details.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:cinemania/features/main/viewmodel/internet_connection_provider.dart';

class DetailsScreen extends HookWidget {
  final Category category;

  const DetailsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final _hasInternet =
        context.watch<InternetConnectionProvider>().hasInternet;

    final scrollController = useScrollController();
    return _hasInternet
        ? SafeArea(
            child: Scaffold(
              // ignore: deprecated_member_use
              body: WillPopScope(
                onWillPop: () async {
                  context.read<AccountBloc>().add(UserFavoritesRequested());
                  backButtonFun(context: context);
                  return true;
                },
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.onSurface,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: BlocConsumer<DetailsBloc, DetailsState>(
                      listener: (context, state) {
                        if (state is DetailsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar.showSnackBar(
                              message: state.errorMessage,
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is DetailsLoading) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        } else if (state is DetailsSuccess) {
                          if (state.scrollableListCategory == 'similar' &&
                              state.scrollableListIndex != 0) {
                            scrollController
                                .jumpTo(MediaQuery.sizeOf(context).height);
                          }

                          if (category == Category.movies) {
                            return state.movie != null
                                ? MovieDetails(movie: state.movie!)
                                : const SizedBox.shrink();
                          } else if (category == Category.tvShows) {
                            return state.tvShow != null
                                ? TVShowDetails(tvShow: state.tvShow!)
                                : const SizedBox.shrink();
                          } else {
                            return state.person != null
                                ? PersonDetails(person: state.person!)
                                : const SizedBox.shrink();
                          }
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        : const NoNetworkScreen();
  }
}
