import 'package:cinemania/common/models/basic_model.dart';
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
      final Map<String, dynamic> movieGenres =
          await homeTMDB.fetchGenresByType(type: 'movie');
      final List<dynamic> genresDynamic =
          movieGenres['genres'] as List<dynamic>;

      for (final genre in genresDynamic) {
        genres.add(Genre.fromJson(genre as Map<String, dynamic>));
      }
      return genres;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Genre>> fetchTvShowGenres() async {
    final List<Genre> genres = [];
    try {
      final Map<String, dynamic> tvShowGenres =
          await homeTMDB.fetchGenresByType(type: 'tv');
      final List<dynamic> genresDynamic =
          tvShowGenres['genres'] as List<dynamic>;

      for (final genre in genresDynamic) {
        genres.add(Genre.fromJson(genre as Map<String, dynamic>));
      }
      return genres;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BasicModel>> fetchTrendingMovies() async {
    final List<BasicModel> movies = [];
    try {
      final Map<String, dynamic> trendingMovies =
          await homeTMDB.fetchTrendingMovies();
      final List<dynamic> moviesDynamic =
          trendingMovies['results'] as List<dynamic>;

      for (final movie in moviesDynamic) {
        movies.add(BasicModel.fromJson(movie as Map<String, dynamic>));
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BasicModel>> fetchMostPopularMovies() async {
    final List<BasicModel> movies = [];
    try {
      // final Map<String, dynamic> mostPopularMovies =
      //     await homeTMDB.fetchTitlesByQuery(
      //       type: 'movie',
      //       query: '&with_genres=$genre&sort_by=vote_count.desc'
      //     );
      // final List<dynamic> moviesDynamic =
      //     mostPopularMovies['results'] as List<dynamic>;

      // for (final movie in moviesDynamic) {
      //   movies.add(BasicModel.fromJson(movie as Map<String, dynamic>));
      // }
      return movies;
    } catch (e) {
      rethrow;
    }
  }
}
