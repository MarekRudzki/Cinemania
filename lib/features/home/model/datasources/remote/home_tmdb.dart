import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchMovieGenres() async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShowGenres() async {
    try {
      final response = await Dio()
          .get('https://api.themoviedb.org/3/genre/tv/list?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
