import 'package:cinemania/features/tv_seasons/model/datasources/remote_datasources/tv_seasons_tmdb.dart';
import 'package:cinemania/features/tv_seasons/model/models/season.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TVSeasonsRepository {
  final TVSeasonsTMDB tmdb;

  TVSeasonsRepository({required this.tmdb});

  Future<Season> fetchSeasonData({
    required int id,
    required int seasonNumber,
  }) async {
    try {
      final Map<String, dynamic> seasonData = await tmdb.fetchSeasonData(
        id: id,
        seasonNumber: seasonNumber,
      );

      return Season.fromJson(seasonData);
    } catch (e) {
      rethrow;
    }
  }
}
