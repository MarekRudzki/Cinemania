import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/details_repository.dart';
import 'package:cinemania/utils/di.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Category category;
  final int id;

  const DetailsScreen({
    super.key,
    required this.category,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final repo = getIt<DetailsRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(id.toString()),
      ),
      body: FutureBuilder(
        future: repo.getTVShowData(id: id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(snapshot.data!.title),
                Text(snapshot.data!.overview),
                Text(snapshot.data!.begginingDate),
                Text(snapshot.data!.endingDate),
                Text(snapshot.data!.url),
                Text(snapshot.data!.cast[0].character),
                Text(snapshot.data!.genres[0].name),
                Text(snapshot.data!.images[0]),
                Text(snapshot.data!.episodesNumber.toString()),
                Text(snapshot.data!.seasonsNumber.toString()),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
