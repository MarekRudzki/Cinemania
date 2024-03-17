import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchTrendingTitles({
    required String category,
    required int page,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/trending/$category/week?page=$page&include_adult=false&api_key=$tmbdKey',
      );
      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTitlesByQuery({
    required String category,
    required String query,
    required int page,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/discover/$category?$query&page=$page&include_adult=false&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchRecommendedTitles({
    required String type,
    required int id,
    required int page,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/$type/$id/recommendations?page=$page&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

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
}
