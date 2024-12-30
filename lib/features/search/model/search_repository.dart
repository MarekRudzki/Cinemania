// ignore_for_file: avoid_dynamic_calls

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_auth.dart';
import 'package:cinemania/features/search/model/datasources/remote/search_firestore.dart';
import 'package:cinemania/features/search/model/datasources/remote/search_tmdb.dart';
import 'package:cinemania/features/search/model/models/search_history_entry.dart';

@lazySingleton
class SearchRepository {
  final SearchTMDB searchTMDB;
  final SearchFirestore searchFirestore;
  final AccountAuth accountAuth;

  SearchRepository({
    required this.searchTMDB,
    required this.accountAuth,
    required this.searchFirestore,
  });

  Future<List<BasicModel>> fetchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final List<BasicModel> movies = [];

      final Map<String, dynamic> moviesData = await searchTMDB.fetchMovies(
        query: query,
        page: page,
      );
      final List<dynamic> moviesDynamic =
          moviesData['results'] as List<dynamic>;
      moviesDynamic.sort((a, b) =>
          (b['popularity'] as double).compareTo(a['popularity'] as double));

      for (final movie in moviesDynamic) {
        movies.add(BasicModel.fromJson(movie as Map<String, dynamic>));
      }

      return movies;
    } on Exception {
      rethrow;
    }
  }

  Future<List<BasicModel>> fetchTvShows({
    required String query,
    required int page,
  }) async {
    try {
      final List<BasicModel> tvShows = [];

      final Map<String, dynamic> tvShowsData = await searchTMDB.fetchTvShows(
        query: query,
        page: page,
      );
      final List<dynamic> tvShowsDynamic =
          tvShowsData['results'] as List<dynamic>;
      tvShowsDynamic.sort((a, b) =>
          (b['popularity'] as double).compareTo(a['popularity'] as double));

      for (final tvShow in tvShowsDynamic) {
        tvShows.add(BasicModel.fromJson(tvShow as Map<String, dynamic>));
      }

      return tvShows;
    } on Exception {
      rethrow;
    }
  }

  Future<List<BasicModel>> fetchCast({
    required String query,
    required int page,
  }) async {
    try {
      final List<BasicModel> cast = [];

      final Map<String, dynamic> castData = await searchTMDB.fetchCast(
        query: query,
        page: page,
      );
      final List<dynamic> castDynamic = castData['results'] as List<dynamic>;
      castDynamic.sort((a, b) =>
          (b['popularity'] as double).compareTo(a['popularity'] as double));

      for (final person in castDynamic) {
        cast.add(BasicModel.fromJson(person as Map<String, dynamic>));
      }

      return cast;
    } on Exception {
      rethrow;
    }
  }

  Future<List<SearchHistoryEntry>> getUserSearches() async {
    try {
      final List<SearchHistoryEntry> searchList = [];
      final searches = await searchFirestore.getUserSearches(
        uid: accountAuth.getUid(),
      );
      if (searches.isNotEmpty) {
        for (final search in searches) {
          searchList
              .add(SearchHistoryEntry.fromJson(search as Map<String, dynamic>));
        }
      }

      return searchList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addSearchToHistory({
    required SearchHistoryEntry searchEntry,
  }) async {
    await searchFirestore.addSearchToHistory(
      searchEntry: searchEntry,
      uid: accountAuth.getUid(),
    );
  }
}
