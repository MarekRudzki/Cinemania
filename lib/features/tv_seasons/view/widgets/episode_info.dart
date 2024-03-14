import 'package:cinemania/features/tv_seasons/model/models/episode.dart';
import 'package:cinemania/features/tv_seasons/view/widgets/episode_photo.dart';
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeInfo extends StatelessWidget {
  final Episode episode;

  const EpisodeInfo({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${episode.number}. ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              episode.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        EpisodePhoto(photoUrl: episode.photoUrl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (episode.releaseDate != 'No data')
              Text(
                episode.releaseDate,
                style: const TextStyle(
                  color: Color.fromARGB(255, 133, 128, 128),
                ),
              ),
            if (episode.runtime != 0)
              Text(
                context
                    .read<TVSeasonsBloc>()
                    .calculateLength(minutes: episode.runtime),
                style: const TextStyle(
                  color: Color.fromARGB(255, 133, 128, 128),
                ),
              ),
            if (episode.voteAverage != 0.0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      episode.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 133, 128, 128),
                      ),
                    ),
                    const Text(
                      '/10',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 133, 128, 128),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
        if (episode.overview != 'No data' && episode.overview.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              episode.overview,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(height: 15),
      ],
    );
  }
}
