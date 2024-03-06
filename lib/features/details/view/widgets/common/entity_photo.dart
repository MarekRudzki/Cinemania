import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntityPhoto extends StatelessWidget {
  final String photoUrl;
  final Category category;
  final int? gender;

  const EntityPhoto({
    super.key,
    required this.photoUrl,
    required this.category,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.35,
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: photoUrl.contains('No data')
          ? Stack(
              children: [
                Image.asset(
                  context.read<DetailsBloc>().getAssetAdress(
                        category: category,
                        gender: gender,
                      ),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 00,
                  left: 0,
                  right: 0,
                  top: MediaQuery.sizeOf(context).height * 0.17,
                  child: const Center(
                    child: Text(
                      'NO IMAGE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : FadeInImage(
              placeholder: AssetImage(
                context.read<DetailsBloc>().getAssetAdress(
                      category: category,
                      gender: gender,
                    ),
              ),
              image: NetworkImage(
                photoUrl,
              ),
              fit: BoxFit.cover,
            ),
    );
  }
}
