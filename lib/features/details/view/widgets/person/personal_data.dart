import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalData extends StatelessWidget {
  final String birthday;
  final String deathday;
  final int height;
  final String name;
  final String placeOfBirth;

  const PersonalData({
    super.key,
    required this.birthday,
    required this.deathday,
    required this.height,
    required this.name,
    required this.placeOfBirth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 15),
            if (birthday != 'Unknown date')
              Row(
                children: [
                  Text(
                    'Born:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    birthday,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            if (placeOfBirth != 'No data')
              Text(
                placeOfBirth,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            if (deathday != 'No data')
              Row(
                children: [
                  Text(
                    'Date of death:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    deathday,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (birthday != 'Unknown date')
              Row(
                children: [
                  Text(
                    'Age:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context
                        .read<DetailsBloc>()
                        .calculateAge(
                          birthday: birthday,
                          deathday: deathday,
                        )
                        .toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (height != 0)
              Row(
                children: [
                  Text(
                    'Height:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$height cm',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
