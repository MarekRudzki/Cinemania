
// import 'package:flutter/widgets.dart';

// class FavoriteButton extends StatelessWidget {
//   final int id;
//   final String name;
//   final String url;
//   final int popularity;

//   const FavoriteButton({
//     super.key,
//     required this.id,
//     required this.name,
//     required this.url,
//     required this.popularity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // context.read<FavoritesBloc>().add(
//     //       FavoriteCheckPressed(id: id),
//     //     );

//     // ignore: avoid_positional_boolean_parameters
//     Future<bool> _onLikeButtonTapped(bool isLiked) async {
//       if (isLiked) {
//         // context.read<FavoritesBloc>().add(
//         //       FavoritesRemovePressed(id: id),
//         //     );
//         // context.read<FavoritesBloc>().add(
//         //       FavoriteCheckPressed(id: id),
//         //     );
//       } else {
//         // context.read<FavoritesBloc>().add(
//         //       FavoritesAddPressed(
//         //         id: id,
//         //         name: name,
//         //         url: url,
//         //         popularity: popularity,
//         //       ),
//         //     );
//         // context.read<FavoritesBloc>().add(
//         //       FavoriteCheckPressed(id: id),
//         //     );
//       }

//       return !isLiked;
//     }

//     return Padding(
//       padding: EdgeInsets.only(
//         top: MediaQuery.sizeOf(context).height * 0.08,
//         right: 7,
//       ),
//       child: BlocBuilder<FavoritesBloc, FavoritesState>(
//         builder: (context, state) {
//           if (state is FavoriteChecked) {
//             return LikeButton(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               isLiked: state.isFavorite,
//               likeBuilder: (bool isLiked) {
//                 return GlowIcon(
//                   Icons.favorite,
//                   color: isLiked
//                       ? Colors.red
//                       : CustomTheme.theme.colorScheme.primary,
//                   size: 30,
//                   glowColor: CustomTheme.theme.colorScheme.tertiary,
//                   blurRadius: 5,
//                 );
//               },
//               onTap: _onLikeButtonTapped,
//             );
//           } else {
//             return nil;
//           }
//         },
//       ),
//     );
//   }
// }
