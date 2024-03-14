import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';
import 'package:cinemania/features/details/view/widgets/common/cast.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/common/genres.dart';
import 'package:cinemania/features/details/view/widgets/common/photos.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/common/similar_titles.dart';
import 'package:cinemania/features/details/view/widgets/tv_show/seasons_and_episodes.dart';
import 'package:cinemania/features/details/view/widgets/tv_show/tv_show_info.dart';
import 'package:flutter/material.dart';

class TVShowDetails extends StatelessWidget {
  final TVShow tvShow;

  const TVShowDetails({super.key, required this.tvShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryPhoto(
                photoUrl: tvShow.url,
                category: Category.tvShows,
                name: tvShow.title,
                id: tvShow.id,
              ),
              Column(
                children: [
                  TVShowInfo(
                    begginingDate: tvShow.begginingDate,
                    endingDate: tvShow.endingDate,
                    episodesNumber: tvShow.episodesNumber,
                    title: tvShow.title,
                    seasonsNumber: tvShow.seasonsNumber,
                    voteAverage: tvShow.voteAverage,
                  ),
                  if (tvShow.genres.isNotEmpty)
                    Genres(
                      genres: tvShow.genres,
                      category: Category.tvShows,
                      sourceId: tvShow.id,
                    )
                ],
              ),
            ],
          ),
          Description(description: tvShow.overview),
          SeasonsAndEpisodes(
            id: tvShow.id,
            seasonsNumber: tvShow.seasonsNumber,
            title: tvShow.title,
          ),
          Cast(
            cast: tvShow.cast,
            sourceCategory: Category.tvShows,
            sourceId: tvShow.id,
          ),
          Photos(photos: tvShow.images),
          if (tvShow.similarTVShows.isNotEmpty)
            SimilarTitles(
              tvShows: tvShow.similarTVShows,
              sourceId: tvShow.id,
            ),
        ],
      ),
    );
  }
}
