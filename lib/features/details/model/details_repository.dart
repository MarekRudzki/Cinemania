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
    final Map<String, dynamic> movieDetails =
        await detailsTMDB.fetchMovieDetails(id: id);

    final Map<String, dynamic> movieImages =
        await detailsTMDB.fetchMovieImages(id: id);
    final Map<String, dynamic> movieCast =
        await detailsTMDB.fetchMovieCast(id: id);

    return Movie.fromJson(
      movieDetails,
      movieImages['backdrops'] as List<dynamic>,
      movieCast['cast'] as List<dynamic>,
    );
  }

  Future<TVShow> fetchTVShowData({
    required int id,
  }) async {
    final Map<String, dynamic> tvShowDetails =
        await detailsTMDB.fetchTvShowDetails(id: id);

    final Map<String, dynamic> tvShowImages =
        await detailsTMDB.fetchTvShowImages(id: id);
    final Map<String, dynamic> tvShowCast =
        await detailsTMDB.fetchTvShowCast(id: id);

    return TVShow.fromJson(
      tvShowDetails,
      tvShowImages['backdrops'] as List<dynamic>,
      tvShowCast['cast'] as List<dynamic>,
    );
  }

  Future<Person> fetchPersonData({
    required int id,
  }) async {
    final Map<String, dynamic> personDetails =
        await detailsTMDB.fetchPersonDetails(id: id);

    final Map<String, dynamic> personImages =
        await detailsTMDB.fetchPersonImages(id: id);
    final Map<String, dynamic> personCredits =
        await detailsTMDB.fetchPersonCredits(id: id);

    final Map<String, dynamic> personHeight = await detailsTMDB
        .fetchPersonHeight(name: personDetails['name'] as String);

    return Person.fromJson(
      personDetails,
      personImages['profiles'] as List<dynamic>,
      personCredits['cast'] as List<dynamic>,
      personHeight,
    );
  }
}
