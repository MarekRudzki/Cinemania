// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';

class SeasonPicker extends StatelessWidget {
  final void Function(int seasonNumber) callback;
  final int seasonsNumber;
  final int selectedSeason;

  const SeasonPicker({
    super.key,
    required this.callback,
    required this.seasonsNumber,
    required this.selectedSeason,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context
          .read<TVSeasonsBloc>()
          .getSeasonsBarHeight(seasonsNumber: seasonsNumber),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2.2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: seasonsNumber,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              callback(index + 1);
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedSeason == index + 1
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.scrim,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Season ${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
