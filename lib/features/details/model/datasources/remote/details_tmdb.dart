import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DetailsTMDB {
  final String tmbdKey = dotenv.env['TMDBkey']!;

  Future<Map<String, dynamic>> fetchMovieDetails({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/movie/$id?api_key=$tmbdKey&append_to_response=images,credits,recommendations');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTvShowDetails({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/tv/$id?api_key=$tmbdKey&append_to_response=images,credits,recommendations');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPersonDetails({
    required int id,
  }) async {
    try {
      final response = await Dio().get(
          'https://api.themoviedb.org/3/person/$id?api_key=$tmbdKey&append_to_response=images,combined_credits');

      return response.data as Map<String, dynamic>;
    } on DioException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPersonHeight({
    required String name,
  }) async {
    final apiKey = dotenv.env['NinjasAPIKey'];

    try {
      final response =
          await Dio().get('https://api.api-ninjas.com/v1/celebrity?name=$name',
              options: Options(headers: {
                'X-Api-Key': apiKey,
              }));
      final List<dynamic> responseDynamic = response.data as List<dynamic>;
      if (responseDynamic.isEmpty) {
        return {};
      } else {
        return responseDynamic[0] as Map<String, dynamic>;
      }
    } catch (error) {
      rethrow;
    }
  }
}
