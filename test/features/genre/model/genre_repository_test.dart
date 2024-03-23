import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/genre/model/datasources/remote/genre_tmdb.dart';
import 'package:cinemania/features/genre/model/genre_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGenreTMDB extends Mock implements GenreTMDB {}

void main() {
  late GenreRepository sut;
  late GenreTMDB genreTMDB;

  setUp(() {
    genreTMDB = MockGenreTMDB();
    sut = GenreRepository(genreTMDB: genreTMDB);
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
    'should fetch genre titles',
    () async {
      when(() => genreTMDB.fetchGenreTitles(
          type: any(named: 'type'),
          genreId: any(named: 'genreId'),
          page: any(named: 'page'))).thenAnswer((_) async => testJson);

      final List<BasicModel> titles = await sut.fetchGenreTitles(
        genreId: 1,
        page: 1,
        type: 'movie',
      );

      expect(titles, [testModel]);
    },
  );
}
