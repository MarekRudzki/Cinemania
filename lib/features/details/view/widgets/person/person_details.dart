// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/view/widgets/common/description.dart';
import 'package:cinemania/features/details/view/widgets/common/primary_photo.dart';
import 'package:cinemania/features/details/view/widgets/person/filmography.dart';
import 'package:cinemania/features/details/view/widgets/person/person_photos.dart';
import 'package:cinemania/features/details/view/widgets/person/personal_data.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';

class PersonDetails extends StatelessWidget {
  final Person person;

  const PersonDetails({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(PhotoValidationPressed(
          url: person.photoUrl,
          id: person.id,
        ));
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
          if (person.filmography.isNotEmpty)
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsSuccess) {
                  return Filmography(
                    filmography: person.filmography,
                    sourceId: person.id,
                    scrollCategory: state.scrollableListCategory,
                    scrollIndex: state.scrollableListIndex,
                  );
                } else
                  return const SizedBox.shrink();
              },
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
