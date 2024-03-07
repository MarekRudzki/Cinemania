import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/person/filmography.dart';
import 'package:cinemania/features/details/view/widgets/person/person_photos.dart';
import 'package:cinemania/features/details/view/widgets/person/personal_data.dart';
import 'package:flutter/material.dart';

class PersonDetails extends StatelessWidget {
  final Person person;

  const PersonDetails({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryPhoto(
                photoUrl: person.photoUrl,
                gender: person.gender,
                category: Category.cast,
                name: person.name,
                id: person.id,
              ),
              PersonalData(
                birthday: person.birthday,
                deathday: person.deathday,
                height: person.height,
                name: person.name,
                placeOfBirth: person.placeOfBirth,
              ),
            ],
          ),
          Description(description: person.biography),
          Filmography(
            filmography: person.filmography,
            sourceId: person.id,
          ),
          if (person.images.length > 1)
            PersonPhotos(
              images: person.images,
              gender: person.gender,
            ),
        ],
      ),
    );
  }
}
