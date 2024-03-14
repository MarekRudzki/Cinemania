import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/genre/model/datasources/remote/genre_tmdb.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenreRepository {
  final GenreTMDB genreTMDB;

  GenreRepository({
    required this.genreTMDB,
  });

  Future<List<BasicModel>> fetchGenreTitles({
    required int genreId,
    required int page,
    required String type,
  }) async {
    try {
      final List<BasicModel> movies = [];

      final Map<String, dynamic> moviesData = await genreTMDB.fetchGenreTitles(
        type: type,
        genreId: genreId,
        page: page,
      );

      final List<dynamic> moviesDynamic =
          moviesData['results'] as List<dynamic>;

      for (final movie in moviesDynamic) {
        movies.add(BasicModel.fromJson(movie as Map<String, dynamic>));
      }

      return movies;
    } on Exception {
      rethrow;
    }
  }
}
