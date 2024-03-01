import 'package:cinemania/features/details/view/details_screen.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultItem extends StatelessWidget {
  final Category category;
  final int id;
  final int? gender;
  final String name;
  final String url;

  const ResultItem({
    super.key,
    required this.category,
    required this.id,
    this.gender,
    required this.name,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                category: category,
                id: id,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.37,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: url.contains('No data')
                  ? Image.asset(
                      context.read<SearchBloc>().getAssetAdress(
                            category: category,
                            gender: gender,
                          ),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      placeholder: AssetImage(
                        context
                            .read<SearchBloc>()
                            .getAssetAdress(
                              category: category,
                              gender: gender,
                            )
                            .replaceAll('no_photo', 'loading'),
                      ),
                      image: NetworkImage(
                        url,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
                child: Center(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
