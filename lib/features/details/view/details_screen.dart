import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/view/widgets/movie/movie_details.dart';
import 'package:cinemania/features/details/view/widgets/person/person_details.dart';
import 'package:cinemania/features/details/view/widgets/tv_show/tv_show_details.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final Category category;

  const DetailsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                        : const SizedBox();
                  } else if (category == Category.tvShows) {
                    return state.tvShow != null
                        ? TVShowDetails(tvShow: state.tvShow!)
                        : const SizedBox();
                  } else {
                    return state.person != null
                        ? PersonDetails(person: state.person!)
                        : const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
