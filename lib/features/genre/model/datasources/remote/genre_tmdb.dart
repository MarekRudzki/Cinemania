import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenreTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchGenreTitles({
    required String type,
    required int genreId,
    required int page,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/discover/$type?page=$page&with_genres=$genreId&sort_by=vote_count.desc&include_adult=false&api_key=$tmbdKey',
      );

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
