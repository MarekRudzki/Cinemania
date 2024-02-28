import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchMovies({
    required String query,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/search/movie?query=$query&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShows({required String query}) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/search/tv?query=$query&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchCast({required String query}) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/search/person?query=$query&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
