import 'package:cinemania/features/tv_seasons/view/tv_seasons_screen.dart';
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeasonsAndEpisodes extends StatelessWidget {
  final int id;
  final int seasonsNumber;
  final String title;

  const SeasonsAndEpisodes({
    super.key,
    required this.id,
    required this.seasonsNumber,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.read<TVSeasonsBloc>().add(
                FetchSeason(
                  id: id,
                  seasonNumber: 1,
                ),
              );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TVSeasonsScreen(
                seasonsNumber: seasonsNumber,
                tvShowId: id,
                showTitle: title,
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: MediaQuery.sizeOf(context).height * 0.05,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Center(
            child: Text(
              'Seasons & Episodes',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
