import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_tmdb.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeRepository {
  final HomeTMDB homeTMDB;

  HomeRepository({
    required this.homeTMDB,
  });

  Future<List<Genre>> fetchMovieGenres() async {
    final List<Genre> genres = [];
    try {
      // final Map<String, dynamic> movieGenres =
      //     await homeTMDB.fetchMovieGenres();
      // final List<dynamic> genresDynamic =
      //     movieGenres['genres'] as List<dynamic>;

      // for (final genre in genresDynamic) {
      //   genres.add(Genre.fromJson(genre as Map<String, dynamic>));
      // }
      return genres;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Genre>> fetchTvShowGenres() async {
    final List<Genre> genres = [];
    try {
      // final Map<String, dynamic> tvShowGenres =
      //     await homeTMDB.fetchTvShowGenres();
      // final List<dynamic> genresDynamic =
      //     tvShowGenres['genres'] as List<dynamic>;

      // for (final genre in genresDynamic) {
      //   genres.add(Genre.fromJson(genre as Map<String, dynamic>));
      // }
      return genres;
    } catch (e) {
      rethrow;
    }
  }
}
