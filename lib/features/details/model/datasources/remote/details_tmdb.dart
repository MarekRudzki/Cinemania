import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DetailsTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  // Movie
  Future<Map<String, dynamic>> fetchMovieDetails({
    required int id,
  }) async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/movie/$id?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchMovieCast({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/movie/$id/credits?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchMovieImages({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/movie/$id/images?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  // TV Show
  Future<Map<String, dynamic>> fetchTvShowDetails({
    required int id,
  }) async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/tv/$id?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShowCast({
    required int id,
  }) async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/tv/$id/credits?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShowImages({
    required int id,
  }) async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/tv/$id/images?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  // Person
  Future<Map<String, dynamic>> fetchPersonDetails({
    required int id,
  }) async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/person/$id?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPersonCredits({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/person/$id/combined_credits?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPersonImages({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/person/$id/images?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
