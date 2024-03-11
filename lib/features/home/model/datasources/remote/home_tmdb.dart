import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchGenresByType({
    required String type,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/genre/$type/list?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchCategoryTitles({
    required String type,
    required String query,
    required int page,
  }) async {
    try {
      //najpop z danej kategorii - query =  &with_genres=$genre&sort_by=vote_count.desc
      // release soon - query = &primary_release_date.gte=2024-03-11&primary_release_date.lte=2024-05-11, category tylko movie
      final response = await Dio().get(
        'https://api.themoviedb.org/3/discover/$type?page=$page$query&include_adult=false&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTrendingTitles({
    required String type,
    required int page,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/trending/$type/day?include_adult=false&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchRecommendedTitles({
    required String type,
    required int id,
  }) async {
    try {
      // tylko jeśli favorites.length > 2
      final response = await Dio().get(
        'https://api.themoviedb.org/3/$type/$id/recommendations?api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
