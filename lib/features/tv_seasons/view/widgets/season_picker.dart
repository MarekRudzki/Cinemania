import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120,
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
                      ? const Color.fromRGBO(55, 164, 94, 1)
                      : Colors.grey.shade600,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Season ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
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