import 'package:cinemania/features/details/model/models/person_filmography.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable {
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
    List<dynamic> imagesJson,
    List<dynamic> filmographyJson,
    Map<String, dynamic> heightJson,
  ) {
    final List<String> images = [];
    final List<PersonFilmography> filmography = [];

    final imagesDataList =
        imagesJson.map((e) => e as Map<String, dynamic>).toList();
    final filmographyDataList =
        filmographyJson.map((e) => e as Map<String, dynamic>).toList();

    final String basicUrl = detailsJson['profile_path'] != null
        ? detailsJson['profile_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    for (final image in imagesDataList) {
      images.add(image['file_path'] as String);
    }

    for (final entity in filmographyDataList) {
      filmography.add(PersonFilmography.fromJson(entity));
    }
    filmography.sort((a, b) => b.popularity.compareTo(a.popularity));

    final double height =
        heightJson['height'] != null ? heightJson['height'] as double : 0;

    return Person(
      biography: detailsJson['biography'] != null
          ? detailsJson['biography'] as String
          : 'No data',
      birthday: detailsJson['birthday'] != null
          ? detailsJson['birthday'] as String
          : 'No data',
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
