// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';

class MovieInfo extends StatelessWidget {
  final int budget;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String title;
  final double voteAverage;

  const MovieInfo({
    super.key,
    required this.budget,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (voteAverage != 0.0)
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 19,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    '/10',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            const SizedBox(height: 5),
            if (releaseDate != 'No data' && releaseDate.isNotEmpty)
              Wrap(
                children: [
                  Text(
                    'Release:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    releaseDate,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (runtime != 0)
              Wrap(
                children: [
                  Text(
                    'Runtime:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context
                        .read<DetailsBloc>()
                        .calculateMovieLength(minutes: runtime),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (budget != 0)
              Wrap(
                children: [
                  Text(
                    'Budget:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context.read<DetailsBloc>().showBigNumer(number: budget),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (revenue != 0)
              Wrap(
                children: [
                  Text(
                    'Revenue:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context.read<DetailsBloc>().showBigNumer(number: revenue),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
