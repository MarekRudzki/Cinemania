import 'package:cinemania/features/search/model/datasources/remote/search_tmdb.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchRepository {
  final SearchTMDB searchTMDB;

  SearchRepository({
    required this.searchTMDB,
  });

  Future<Map<String, dynamic>> fetchMovies({
    required String query,
  }) async {
    try {
      searchTMDB.fetchMovies(query: query);

      return {};
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShows({
    required String query,
  }) async {
    try {
      searchTMDB.fetchTvShows(query: query);

      return {};
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchCast({
    required String query,
  }) async {
    try {
      searchTMDB.fetchCast(query: query);

      return {};
    } on Exception {
      rethrow;
    }
  }
}
