// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:like_button/like_button.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Category category;
  final int id;
  final String name;
  final String url;
  final int? gender;

  const FavoriteButton({
    super.key,
    required this.category,
    required this.id,
    required this.name,
    required this.url,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final isItemFav =
        context.read<AccountBloc>().checkIfLocalFavoritesContains(id: id);

    Future<bool> _onLikeButtonTapped(bool isLiked) async {
      if (isLiked) {
        context.read<AccountBloc>().add(
              DeleteFavoritePressed(id: id),
            );
        context.read<AccountBloc>().deleteSingleFavFromLocalFavorites(id: id);
      } else {
        context.read<AccountBloc>().add(
              AddFavoritePressed(
                category: category,
                id: id,
                name: name,
                url: url,
                gender: gender,
              ),
            );
        context.read<AccountBloc>().addSingleFavToLocalFavorites(
                favorite: Favorite(
              category: category,
              id: id,
              name: name,
              url: url,
            ));
      }
      return !isLiked;
    }

    return Positioned(
      top: 10,
      right: 10,
      child: LikeButton(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        isLiked: isItemFav,
        likeBuilder: (bool isLiked) {
          return GlowIcon(
            Icons.favorite,
            color: isLiked ? Theme.of(context).colorScheme.error : Colors.grey,
            size: 30,
            glowColor: Colors.black,
            blurRadius: 5,
          );
        },
        onTap: _onLikeButtonTapped,
      ),
    );
  }
}
