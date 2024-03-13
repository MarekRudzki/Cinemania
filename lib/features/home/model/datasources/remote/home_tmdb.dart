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

  Future<Map<String, dynamic>> fetchTitlesByQuery({
    required String type,
    required String query,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/discover/$type?$query&include_adult=false&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTrendingMovies() async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/trending/movie/day?include_adult=false&api_key=$tmbdKey',
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
      final response = await Dio().get(
        'https://api.themoviedb.org/3/$type/$id/recommendations?api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
