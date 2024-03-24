// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/basic_model.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/genre/model/genre_repository.dart';
import 'package:cinemania/features/genre/model/models/genre_page_model.dart';
import 'package:cinemania/features/genre/viewmodel/bloc/genre_bloc.dart';

class MockGenreRepository extends Mock implements GenreRepository {}

void main() {
  late GenreBloc sut;
  late GenreRepository genreRepository;

  setUp(() {
    genreRepository = MockGenreRepository();
    sut = GenreBloc(genreRepository);
  });

  final BasicModel testModel = BasicModel(
    id: 1,
    imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
    gender: 0,
    name: 'Test',
  );
  test(
    'should fetch genre titles',
    () {
      when(() => genreRepository.fetchGenreTitles(
            genreId: any(named: 'genreId'),
            page: any(named: 'page'),
            type: any(named: 'type'),
          )).thenAnswer((_) async => [testModel]);

      expectLater(
          sut.onNewListingState,
          emitsInOrder([
            emits(GenreState()),
            emits(GenreState(movies: [testModel], page: null)),
          ]));

      sut.onPageRequestSink.add(GenrePageModel(
        page: 1,
        category: Category.movies,
        genre: 1,
      ));
    },
  );
}
