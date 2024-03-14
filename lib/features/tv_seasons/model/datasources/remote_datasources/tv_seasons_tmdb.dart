import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TVSeasonsTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchSeasonData({
    required int id,
    required int seasonNumber,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/tv/$id/season/$seasonNumber?api_key=$tmbdKey');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }
}
