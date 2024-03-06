import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/view/widgets/common/custom_back_button.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPhoto extends StatelessWidget {
  final String photoUrl;
  final Category category;
  final int? gender;

  const PrimaryPhoto({
    super.key,
    required this.photoUrl,
    required this.category,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      height: MediaQuery.sizeOf(context).height * 0.37,
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
                  top: MediaQuery.sizeOf(context).height * 0.22,
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
                const CustomBackButton(),
              ],
            )
          : Stack(
              children: [
                FadeInImage(
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
                const CustomBackButton(),
              ],
            ),
    );
  }
}
