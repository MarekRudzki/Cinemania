import 'package:cinemania/features/details/model/datasources/remote/details_tmdb.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DetailsRepository {
  final DetailsTMDB detailsTMDB;

  DetailsRepository({
    required this.detailsTMDB,
  });

  Future<Movie> fetchMovieData({
    required int id,
  }) async {
    try {
      final Map<String, dynamic> movieDetails =
          await detailsTMDB.fetchMovieDetails(id: id);
      return Movie.fromJson(movieDetails);
    } catch (e) {
      rethrow;
    }
  }

  Future<TVShow> fetchTVShowData({
    required int id,
  }) async {
    try {
      final Map<String, dynamic> tvShowDetails =
          await detailsTMDB.fetchTvShowDetails(id: id);

      return TVShow.fromJson(tvShowDetails);
    } catch (e) {
      rethrow;
    }
  }

  Future<Person> fetchPersonData({
    required int id,
  }) async {
    try {
      final Map<String, dynamic> personDetails =
          await detailsTMDB.fetchPersonDetails(id: id);
      final Map<String, dynamic> personHeight = await detailsTMDB
          .fetchPersonHeight(name: personDetails['name'] as String);

      return Person.fromJson(
        personDetails,
        personHeight,
      );
    } catch (e) {
      rethrow;
    }
  }
}
