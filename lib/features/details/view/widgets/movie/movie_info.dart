import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (voteAverage != 0.0)
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '/10',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            const SizedBox(height: 5),
            if (releaseDate != 'No data')
              Row(
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
              Row(
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
              Row(
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
              Row(
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
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
