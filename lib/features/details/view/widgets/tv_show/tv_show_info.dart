import 'package:flutter/material.dart';

class TVShowInfo extends StatelessWidget {
  final String begginingDate;
  final String endingDate;
  final int episodesNumber;
  final String title;
  final int seasonsNumber;
  final double voteAverage;

  const TVShowInfo({
    super.key,
    required this.begginingDate,
    required this.endingDate,
    required this.episodesNumber,
    required this.title,
    required this.seasonsNumber,
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
            Row(
              children: [
                if (begginingDate != 'No data' && begginingDate.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        begginingDate.substring(0, 4),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        ' - ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (endingDate != 'No data')
                        Text(
                          endingDate.substring(0, 4),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 5),
            if (seasonsNumber != 0)
              Row(
                children: [
                  Text(
                    'Seasons:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$seasonsNumber',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (episodesNumber != 0)
              Row(
                children: [
                  Text(
                    'Episodes:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$episodesNumber',
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
