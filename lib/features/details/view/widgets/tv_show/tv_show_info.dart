import 'package:cinemania/common/models/genre.dart';
import 'package:flutter/material.dart';

class TVShowInfo extends StatelessWidget {
  final String begginingDate;
  final String endingDate;
  final int episodesNumber;
  final List<Genre> genres;
  final String title;
  final int seasonsNumber;
  final double voteAverage;

  const TVShowInfo({
    super.key,
    required this.begginingDate,
    required this.endingDate,
    required this.episodesNumber,
    required this.genres,
    required this.title,
    required this.seasonsNumber,
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
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Text(
                    '/10',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            const SizedBox(height: 5),

            Row(
              children: [
                if (begginingDate != 'No data')
                  Row(
                    children: [
                      Text(
                        begginingDate.substring(0, 4),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        ' - ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      if (endingDate != 'No data')
                        Text(
                          endingDate.substring(0, 4),
                          style: const TextStyle(
                            color: Colors.white,
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
                  const Text(
                    'Seasons:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$seasonsNumber',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (episodesNumber != 0)
              Row(
                children: [
                  const Text(
                    'Episodes:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$episodesNumber',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            // if (genres.isNotEmpty)//TODO
            //   Flex(

            //     child: Expanded(
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: genres.length,
            //         itemBuilder: (context, index) => Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           child: Text(
            //             genres[index].name,
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}
