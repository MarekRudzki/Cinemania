import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/category/model/datasources/remote/category_tmdb.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CategoryRepository {
  final CategoryTMDB categoryTMDB;

  CategoryRepository({
    required this.categoryTMDB,
  });

  Future<List<BasicModel>> fetchCategoryTitles({
    required String query,
    required int page,
    required String type,
  }) async {
    try {
      final List<BasicModel> movies = [];

      final Map<String, dynamic> moviesData =
          await categoryTMDB.fetchCategoryTitles(
        type: type,
        query: query,
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
