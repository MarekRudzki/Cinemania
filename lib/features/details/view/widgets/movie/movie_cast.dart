import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/models/cast_member.dart';
import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/details/view/widgets/common/entity_photo.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCast extends StatelessWidget {
  final List<CastMember> cast;

  const MovieCast({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cast:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.42,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final person = cast[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DetailsScreen(
                          category: Category.cast,
                        ),
                      ));
                      context
                          .read<DetailsBloc>()
                          .add(FetchPersonDataPressed(id: person.id));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: EntityPhoto(
                            photoUrl: person.url,
                            category: Category.cast,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.33,
                          child: Column(
                            children: [
                              Text(
                                person.name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'as',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 128, 128),
                                ),
                              ),
                              Text(
                                person.character,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
