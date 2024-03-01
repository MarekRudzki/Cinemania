import 'package:cinemania/common/models/movie_basic.dart';
import 'package:cinemania/common/models/person_basic.dart';
import 'package:cinemania/common/models/tv_show_basic.dart';
import 'package:cinemania/features/search/model/datasources/remote/search_tmdb.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchRepository {
  final SearchTMDB searchTMDB;

  SearchRepository({
    required this.searchTMDB,
  });

  Future<List<MovieBasic>> fetchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final List<MovieBasic> movies = [];

      final Map<String, dynamic> moviesData = await searchTMDB.fetchMovies(
        query: query,
        page: page,
      );
      final List<dynamic> moviesDynamic =
          moviesData['results'] as List<dynamic>;

      for (final movie in moviesDynamic) {
        movies.add(MovieBasic.fromJson(movie as Map<String, dynamic>));
      }

      return movies;
    } on Exception {
      rethrow;
    }
  }

  Future<List<TVShowBasic>> fetchTvShows({
    required String query,
    required int page,
  }) async {
    try {
      final List<TVShowBasic> tvShows = [];

      final Map<String, dynamic> tvShowsData = await searchTMDB.fetchTvShows(
        query: query,
        page: page,
      );
      final List<dynamic> tvShowsDynamic =
          tvShowsData['results'] as List<dynamic>;

      for (final tvShow in tvShowsDynamic) {
        tvShows.add(TVShowBasic.fromJson(tvShow as Map<String, dynamic>));
      }

      return tvShows;
    } on Exception {
      rethrow;
    }
  }

  Future<List<PersonBasic>> fetchCast({
    required String query,
    required int page,
  }) async {
    try {
      final List<PersonBasic> cast = [];

      final Map<String, dynamic> castData = await searchTMDB.fetchCast(
        query: query,
        page: page,
      );
      final List<dynamic> castDynamic = castData['results'] as List<dynamic>;

      for (final person in castDynamic) {
        cast.add(PersonBasic.fromJson(person as Map<String, dynamic>));
      }

      return cast;
    } on Exception {
      rethrow;
    }
  }
}
