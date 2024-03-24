// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/search/model/datasources/remote/search_tmdb.dart';
import 'package:cinemania/features/search/model/search_repository.dart';

class MockSearchTMDB extends Mock implements SearchTMDB {}

void main() {
  late SearchRepository sut;
  late SearchTMDB tmdb;

  setUp(() {
    tmdb = MockSearchTMDB();
    sut = SearchRepository(searchTMDB: tmdb);
  });

  test(
    'should fetch movies',
    () async {
      final Map<String, dynamic> testJson = {
        'results': [
          {
            'id': 1,
            'name': 'Test',
            'poster_path': '/test.jpg',
          }
        ]
      };
      final BasicModel testModel = BasicModel(
        id: 1,
        imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
        gender: 0,
        name: 'Test',
      );
      when(() => tmdb.fetchMovies(query: 'Test', page: 1))
          .thenAnswer((_) async => testJson);

      final movies = await sut.fetchMovies(query: 'Test', page: 1);

      expect(
        movies,
        [testModel],
      );
    },
  );

  test(
    'should fetch tv shows',
    () async {
      final Map<String, dynamic> testJson = {
        'results': [
          {
            'id': 2,
            'name': 'Test2',
            'poster_path': '/test2.jpg',
          }
        ]
      };
      final BasicModel testModel = BasicModel(
        id: 2,
        imageUrl: 'https://image.tmdb.org/t/p/w500/test2.jpg',
        gender: 0,
        name: 'Test2',
      );
      when(() => tmdb.fetchTvShows(query: 'Test2', page: 1))
          .thenAnswer((_) async => testJson);

      final tvShows = await sut.fetchTvShows(query: 'Test2', page: 1);

      expect(
        tvShows,
        [testModel],
      );
    },
  );

  test(
    'should fetch cast',
    () async {
      final Map<String, dynamic> testJson = {
        'results': [
          {
            'id': 3,
            'name': 'Test3',
            'gender': 1,
            'profile_path': '/test3.jpg',
          }
        ]
      };
      final BasicModel testModel = BasicModel(
        id: 3,
        imageUrl: 'https://image.tmdb.org/t/p/w500/test3.jpg',
        gender: 1,
        name: 'Test3',
      );
      when(() => tmdb.fetchCast(query: 'Test', page: 1))
          .thenAnswer((_) async => testJson);

      final cast = await sut.fetchCast(query: 'Test', page: 1);

      expect(
        cast,
        [testModel],
      );
    },
  );
}
