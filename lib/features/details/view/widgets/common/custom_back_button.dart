import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/details/model/models/details_history.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 00,
      left: 00,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 6.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
            Shadow(
              blurRadius: 6.0,
              offset: Offset(
                3.0,
                0.0,
              ),
            ),
          ],
        ),
        onPressed: () {
          context.read<AccountBloc>().add(UserFavoritesRequested());
          final List<DetailsHistory> history =
              context.read<DetailsBloc>().history;

          if (history.isNotEmpty) {
            if (history.last.category == Category.movies) {
              context
                  .read<DetailsBloc>()
                  .add(FetchMovieDataPressed(id: history.last.id));
            } else if (history.last.category == Category.tvShows) {
              context
                  .read<DetailsBloc>()
                  .add(FetchTVShowDataPressed(id: history.last.id));
            } else {
              context
                  .read<DetailsBloc>()
                  .add(FetchPersonDataPressed(id: history.last.id));
            }
            Navigator.of(context).pop();
            context.read<DetailsBloc>().add(DeleteLastHistoryElementPressed());
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
