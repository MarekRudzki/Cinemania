import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/common/models/genre.dart';
import 'package:cinemania/features/details/model/datasources/remote/details_tmdb.dart';
import 'package:cinemania/features/details/model/details_repository.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailsTMDB extends Mock implements DetailsTMDB {}

void main() {
  late DetailsRepository sut;
  late DetailsTMDB detailsTMDB;

  setUp(() {
    detailsTMDB = MockDetailsTMDB();
    sut = DetailsRepository(detailsTMDB: detailsTMDB);
  });

  test(
    'should fetch movie data',
    () async {
      final Map<String, dynamic> movieJson = {
        'id': 1,
        'budget': 1,
        'genres': [
          {'id': 1, 'name': 'Test'}
        ],
        'overview': 'Test',
        'poster_path': '/test.jpg',
        'release_date': 'Test',
        'revenue': 1,
        'runtime': 1,
        'title': 'Test',
        'vote_average': 10.0,
        'images': {
          'backdrops': [
            {
              'file_path': '/test.jpg',
            }
          ]
        },
        'credits': {
          'cast': [
            {
              'character': 'Test',
              'gender': 1,
              'id': 1,
              'name': 'Test',
              'profile_path': '/test.jpg',
            }
          ]
        },
        'recommendations': {
          'results': [
            {'id': 1, 'name': 'Test', 'poster_path': '/test.jpg'}
          ],
        }
      };

      final Movie movieTest = Movie(
          id: 1,
          budget: 1,
          genres: [Genre(id: 1, name: 'Test')],
          overview: 'Test',
          url: 'https://image.tmdb.org/t/p/w500/test.jpg',
          releaseDate: 'Test',
          revenue: 1,
          runtime: 1,
          title: 'Test',
          voteAverage: 10.0,
          images: ['https://image.tmdb.org/t/p/w500/test.jpg'],
          cast: [
            CastMember(
                character: 'Test',
                gender: 1,
                id: 1,
                name: 'Test',
                url: 'https://image.tmdb.org/t/p/w500/test.jpg')
          ],
          similarMovies: [
            BasicModel(
              id: 1,
              imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
              name: 'Test',
            )
          ]);
      when(() => detailsTMDB.fetchMovieDetails(id: any(named: 'id')))
          .thenAnswer((_) async => movieJson);

      final Movie movie = await sut.fetchMovieData(id: 1);

      expect(movie, movieTest);
    },
  );

  test(
    'should fetch tv show data',
    () async {
      final Map<String, dynamic> tvShowJson = {
        'id': 1,
        'first_air_date': 'Test',
        'last_air_date': 'Test',
        'number_of_seasons': 1,
        'number_of_episodes': 1,
        'genres': [
          {'id': 1, 'name': 'Test'}
        ],
        'overview': 'Test',
        'poster_path': '/test.jpg',
        'name': 'Test',
        'vote_average': 10.0,
        'images': {
          'backdrops': [
            {
              'file_path': '/test.jpg',
            }
          ]
        },
        'aggregate_credits': {
          'cast': [
            {
              'character': 'Test',
              'gender': 1,
              'id': 1,
              'name': 'Test',
              'profile_path': '/test.jpg',
            }
          ]
        },
        'recommendations': {
          'results': [
            {'id': 1, 'name': 'Test', 'poster_path': '/test.jpg'}
          ],
        }
      };

      final TVShow tvShowTest = TVShow(
          id: 1,
          begginingDate: 'Test',
          endingDate: 'Test',
          seasonsNumber: 1,
          episodesNumber: 1,
          genres: [Genre(id: 1, name: 'Test')],
          overview: 'Test',
          url: 'https://image.tmdb.org/t/p/w500/test.jpg',
          title: 'Test',
          voteAverage: 10.0,
          images: ['https://image.tmdb.org/t/p/w500/test.jpg'],
          cast: [
            CastMember(
                character: 'Test',
                gender: 1,
                id: 1,
                name: 'Test',
                url: 'https://image.tmdb.org/t/p/w500/test.jpg')
          ],
          similarTVShows: [
            BasicModel(
              id: 1,
              imageUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
              name: 'Test',
            )
          ]);
      when(() => detailsTMDB.fetchTvShowDetails(id: any(named: 'id')))
          .thenAnswer((_) async => tvShowJson);

      final tvShow = await sut.fetchTVShowData(id: 1);

      expect(tvShow, tvShowTest);
    },
  );

  test(
    'should fetch person data',
    () async {
      final Map<String, dynamic> personJson = {
        'id': 1,
        'biography': 'Test',
        'birthday': 'Test',
        'deathday': 'Test',
        'gender': 1,
        'name': 'Test',
        'place_of_birth': 'Test',
        'profile_path': '/test.jpg',
        'images': {
          'profiles': [
            {
              'file_path': '/test.jpg',
            }
          ]
        },
        'combined_credits': {
          'cast': [
            {
              'id': 1,
              'media_type': 'movie',
              'poster_path': '/test.jpg',
              'character': 'Test',
              'popularity': 1.0,
              'title': 'Test',
              'release_date': '1',
            }
          ]
        }
      };
      final Person personTest = Person(
          id: 1,
          biography: 'Test',
          birthday: 'Test',
          deathday: 'Test',
          gender: 1,
          name: 'Test',
          height: 100,
          placeOfBirth: 'Test',
          photoUrl: 'https://image.tmdb.org/t/p/w500/test.jpg',
          images: [
            'https://image.tmdb.org/t/p/w500/test.jpg'
          ],
          filmography: [
            PersonFilmography(
              id: 1,
              mediaType: 'movie',
              url: 'https://image.tmdb.org/t/p/w500/test.jpg',
              character: 'Test',
              popularity: 1.0,
              title: 'Test',
              year: '1',
            )
          ]);
      when(() => detailsTMDB.fetchPersonDetails(id: any(named: 'id')))
          .thenAnswer((_) async => personJson);
      when(() => detailsTMDB.fetchPersonHeight(name: any(named: 'name')))
          .thenAnswer((_) async => {
                'height': 1.0,
              });

      final Person person = await sut.fetchPersonData(id: 1);

      expect(person, personTest);
    },
  );
}
