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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Born:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 133, 128, 128),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  birthday,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                if (placeOfBirth != 'No data')
                  const Text(
                    'in',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
                    ),
                  ),
              ],
            ),
            if (placeOfBirth != 'No data')
              Text(
                placeOfBirth,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            if (deathday != 'No data')
              Row(
                children: [
                  const Text(
                    'Date of death:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    deathday,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (birthday != 'Unknown date')
              Row(
                children: [
                  const Text(
                    'Age:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
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
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            if (height != 0)
              Row(
                children: [
                  const Text(
                    'Height:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 128, 128),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$height cm',
                    style: const TextStyle(
                      color: Colors.white,
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
