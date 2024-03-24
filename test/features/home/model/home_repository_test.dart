// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/features/genre/model/models/genre.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_auth.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_firestore.dart';
import 'package:cinemania/features/home/model/datasources/remote/home_tmdb.dart';
import 'package:cinemania/features/home/model/home_repository.dart';

class MockHomeTMDB extends Mock implements HomeTMDB {}

class MockHomeFirestore extends Mock implements HomeFirestore {}

class MockHomeAuth extends Mock implements HomeAuth {}

void main() {
  late HomeRepository sut;
  late HomeTMDB homeTMDB;
  late HomeFirestore homeFirestore;
  late HomeAuth homeAuth;

  setUp(() {
    homeTMDB = MockHomeTMDB();
    homeFirestore = MockHomeFirestore();
    homeAuth = MockHomeAuth();

    sut = HomeRepository(
      homeTMDB: homeTMDB,
      homeFirestore: homeFirestore,
      homeAuth: homeAuth,
    );
  });
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

  test(
    'should fetch trending titles',
    () async {
      when(() => homeTMDB.fetchTrendingTitles(
            category: any(named: 'category'),
            page: any(named: 'page'),
          )).thenAnswer((_) async => testJson);

      final List<BasicModel> titles = await sut.fetchTrendingTitles(
        category: 'movie',
        page: 1,
      );

      expect(titles, [testModel]);
    },
  );

  test(
    'should fetch titles by query',
    () async {
      when(() => homeTMDB.fetchTitlesByQuery(
            category: any(named: 'category'),
            page: any(named: 'page'),
            query: any(named: 'query'),
          )).thenAnswer((_) async => testJson);

      final List<BasicModel> titles = await sut.fetchTitlesByQuery(
          category: 'movie', page: 1, query: 'Testing');

      expect(titles, [testModel]);
    },
  );

  test(
    'should fetch if user have favorites saved in firestore',
    () async {
      when(() => homeAuth.getUid()).thenReturn('1');
      when(() => homeFirestore.userHaveFavorites(uid: any(named: 'uid')))
          .thenAnswer((_) async => true);

      final bool haveFavorites = await sut.userHaveFavorites();

      expect(haveFavorites, true);
    },
  );

  test(
    'should fetch random favorite id by category',
    () async {
      when(() => homeAuth.getUid()).thenReturn('1');
      when(() => homeFirestore.getRandomFavoriteId(
          uid: any(named: 'uid'),
          category: any(named: 'category'))).thenAnswer((_) async => 1);

      final int id = await sut.fetchRandomFavoriteId(category: 'movie');

      expect(id, 1);
    },
  );

  test(
    'should fetch recommended titles',
    () async {
      when(() => homeTMDB.fetchRecommendedTitles(
            type: any(named: 'type'),
            page: any(named: 'page'),
            id: any(named: 'id'),
          )).thenAnswer((_) async => testJson);

      final List<BasicModel> titles = await sut.fetchRecommendedTitles(
        type: 'movie',
        page: 1,
        id: 1,
      );

      expect(titles, [testModel]);
    },
  );

  test(
    'should fetch genres by type',
    () async {
      final Map<String, dynamic> genresTestJson = {
        'genres': [
          {
            'id': 1,
            'name': 'Test',
          }
        ]
      };

      final Genre genreTestModel = Genre(id: 1, name: 'Test');

      when(() => homeTMDB.fetchGenresByType(
            type: any(named: 'type'),
          )).thenAnswer((_) async => genresTestJson);

      final List<Genre> genres = await sut.fetchGenresByType(
        type: 'movie',
      );

      expect(genres, [genreTestModel]);
    },
  );
}
