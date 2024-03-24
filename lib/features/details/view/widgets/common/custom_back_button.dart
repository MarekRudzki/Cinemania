// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:cinemania/common/back_button_fun.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 00,
      left: 00,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
          shadows: [
            const Shadow(
              blurRadius: 6.0,
              offset: Offset(
                0.0,
                3.0,
              ),
            ),
            const Shadow(
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
          backButtonFun(context: context);
        },
      ),
    );
  }
}
