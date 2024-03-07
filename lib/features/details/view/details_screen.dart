import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/details/model/models/details_history.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_details.dart';
import 'package:cinemania/features/details/view/widgets/person/person_details.dart';
import 'package:cinemania/features/details/view/widgets/tv_show/tv_show_details.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final Category category;

  const DetailsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            context.read<AccountBloc>().add(UserFavoritesRequested());
            final List<DetailsHistory> history =
                context.read<DetailsBloc>().history;

            if (history.isNotEmpty) {
              if (history.last.category == Category.movies) {
                context
                    .read<DetailsBloc>()
                    .add(FetchMovieDataPressed(id: history.last.id));
              } else if (history.last.category == Category.tvShows) {
                context
                    .read<DetailsBloc>()
                    .add(FetchTVShowDataPressed(id: history.last.id));
              } else {
                context
                    .read<DetailsBloc>()
                    .add(FetchPersonDataPressed(id: history.last.id));
              }
              Navigator.of(context).pop();
              context
                  .read<DetailsBloc>()
                  .add(DeleteLastHistoryElementPressed());
            } else {
              Navigator.of(context).pop();
            }
            return true;
          },
          child: Container(
            height: double.infinity,
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
            child: SingleChildScrollView(
              child: BlocConsumer<DetailsBloc, DetailsState>(
                listener: (context, state) {
                  if (state is DetailsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.showSnackBar(
                        message: state.errorMessage,
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is DetailsLoading) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (state is DetailsSuccess) {
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
    );
  }
}
