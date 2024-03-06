import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String biography;
  final String birthday;
  final String deathday;
  final int gender;
  final int height;
  final String name;
  final String placeOfBirth;
  final String photoUrl;
  final List<String> images;
  final List<PersonFilmography> filmography;

  Person({
    required this.id,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.name,
    required this.height,
    required this.placeOfBirth,
    required this.photoUrl,
    required this.images,
    required this.filmography,
  });

  factory Person.fromJson(
    Map<String, dynamic> detailsJson,
    Map<String, dynamic> heightJson,
  ) {
    final List<String> images = [];
    final List<PersonFilmography> filmography = [];

    final imagesDynamic = (detailsJson['images']
        as Map<String, dynamic>)['profiles'] as List<dynamic>;
    final imagesDataList =
        imagesDynamic.map((e) => e as Map<String, dynamic>).toList();

    final filmographyDynamic = (detailsJson['combined_credits']
        as Map<String, dynamic>)['cast'] as List<dynamic>;
    final filmographyDataList =
        filmographyDynamic.map((e) => e as Map<String, dynamic>).toList();

    for (final image in imagesDataList) {
      final imageUrlEndpoint = image['file_path'] as String;
      final String url = 'https://image.tmdb.org/t/p/w500$imageUrlEndpoint';
      images.add(url);
    }

    for (final entity in filmographyDataList) {
      // Delete duplicates
      if (!filmography.any((item) => item.title == entity['original_name']) ||
          !filmography.any((item) => item.title == entity['title'])) {
        filmography.add(PersonFilmography.fromJson(entity));
      }
    }
    filmography.sort((a, b) => b.popularity.compareTo(a.popularity));

    final double height =
        heightJson['height'] != null ? heightJson['height'] as double : 0;

    final String basicUrl = detailsJson['profile_path'] != null
        ? detailsJson['profile_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return Person(
      id: detailsJson['id'] as int,
      biography: detailsJson['biography'] != null
          ? detailsJson['biography'] as String
          : 'No data',
      birthday: detailsJson['birthday'] != null
          ? detailsJson['birthday'] as String
          : 'Unknown date',
      deathday: detailsJson['deathday'] != null
          ? detailsJson['deathday'] as String
          : 'No data',
      gender: detailsJson['gender'] != null ? detailsJson['gender'] as int : 0,
      height: (height * 100).toInt(),
      name: detailsJson['name'] != null
          ? detailsJson['name'] as String
          : 'No data',
      placeOfBirth: detailsJson['place_of_birth'] != null
          ? detailsJson['place_of_birth'] as String
          : 'No data',
      photoUrl: fullUrl,
      images: images,
      filmography: filmography,
    );
  }

  @override
  List<Object?> get props => [
        id,
        biography,
        birthday,
        deathday,
        gender,
        height,
        name,
        placeOfBirth,
        photoUrl,
        images,
        filmography,
      ];
}
