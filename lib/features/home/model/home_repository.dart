// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_auth.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_firestore.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_tmdb.dart';

@lazySingleton
class HomeRepository {
  final HomeTMDB homeTMDB;
  final HomeFirestore homeFirestore;
  final HomeAuth homeAuth;

  HomeRepository({
    required this.homeTMDB,
    required this.homeFirestore,
    required this.homeAuth,
  });

  Future<List<BasicModel>> fetchTrendingTitles({
    required String category,
    required int page,
  }) async {
    final List<BasicModel> titles = [];
    try {
      final Map<String, dynamic> trendingTitles =
          await homeTMDB.fetchTrendingTitles(
        page: page,
        category: category,
      );
      final List<dynamic> titlesDynamic =
          trendingTitles['results'] as List<dynamic>;

      for (final title in titlesDynamic) {
        titles.add(BasicModel.fromJson(title as Map<String, dynamic>));
      }
      return titles;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BasicModel>> fetchTitlesByQuery({
    required String category,
    required String query,
    required int page,
  }) async {
    final List<BasicModel> titles = [];
    try {
      final Map<String, dynamic> titlesByQuery =
          await homeTMDB.fetchTitlesByQuery(
        page: page,
        query: query,
        category: category,
      );
      final List<dynamic> titlesDynamic =
          titlesByQuery['results'] as List<dynamic>;

      for (final title in titlesDynamic) {
        titles.add(BasicModel.fromJson(title as Map<String, dynamic>));
      }
      return titles;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> userHaveFavorites() async {
    try {
      final String uid = homeAuth.getUid();

      final haveFavorites = await homeFirestore.userHaveFavorites(uid: uid);
      return haveFavorites;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> fetchRandomFavoriteId({
    required String category,
  }) async {
    try {
      final String uid = homeAuth.getUid();

      final int id = await homeFirestore.getRandomFavoriteId(
        uid: uid,
        category: category,
      );
      return id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<BasicModel>> fetchRecommendedTitles({
    required String type,
    required int id,
    required int page,
  }) async {
    final List<BasicModel> titles = [];
    try {
      final Map<String, dynamic> recommendedTitles =
          await homeTMDB.fetchRecommendedTitles(
        type: type,
        page: page,
        id: id,
      );
      final List<dynamic> titlesDynamic =
          recommendedTitles['results'] as List<dynamic>;

      for (final title in titlesDynamic) {
        titles.add(BasicModel.fromJson(title as Map<String, dynamic>));
      }
      return titles;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Genre>> fetchGenresByType({
    required String type,
  }) async {
    final List<Genre> genres = [];
    try {
      final Map<String, dynamic> genresList =
          await homeTMDB.fetchGenresByType(type: type);
      final List<dynamic> genresDynamic = genresList['genres'] as List<dynamic>;

      for (final genre in genresDynamic) {
        genres.add(Genre.fromJson(genre as Map<String, dynamic>));
      }
      return genres;
    } catch (e) {
      rethrow;
    }
  }
}
