import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';
import 'package:cinemania/features/details/view/widgets/common/cast.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/common/photos.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/common/similar_titles.dart';
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
              ),
              TVShowInfo(
                begginingDate: tvShow.begginingDate,
                endingDate: tvShow.endingDate,
                episodesNumber: tvShow.episodesNumber,
                genres: tvShow.genres,
                title: tvShow.title,
                seasonsNumber: tvShow.seasonsNumber,
                voteAverage: tvShow.voteAverage,
              ),
            ],
          ),
          Description(description: tvShow.overview),
          Cast(
            cast: tvShow.cast,
            sourceCategory: Category.tvShows,
            sourceId: tvShow.id,
          ),
          Photos(photos: tvShow.images),
          if (tvShow.similarTVShows.isNotEmpty)
            SimilarTitles(
              tvShows: tvShow.similarTVShows,
            ),
        ],
      ),
    );
  }
}
