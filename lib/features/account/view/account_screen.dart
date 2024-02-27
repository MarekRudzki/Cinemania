import 'package:cinemania/features/account/view/widgets/change_password.dart';
import 'package:cinemania/features/account/view/widgets/change_username.dart';
import 'package:cinemania/features/account/view/widgets/delete_account.dart';
import 'package:cinemania/features/account/view/widgets/favorites.dart';
import 'package:cinemania/features/account/view/widgets/logout.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordChangeVisible =
        context.read<AccountBloc>().passwordChangePossible();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color.fromARGB(255, 45, 15, 50),
                Color.fromARGB(255, 87, 25, 98),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    const Spacer(),
                    Text(
                      context.watch<AccountBloc>().getUsername(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      iconColor: Colors.white,
                      color: const Color.fromARGB(255, 87, 25, 98),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(child: ChangeUsername()),
                          if (passwordChangeVisible)
                            const PopupMenuItem(child: ChangePassword()),
                          const PopupMenuItem(child: DeleteAccount()),
                          const PopupMenuItem(child: Logout()),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              const Favorites(),
            ],
          ),
        ),
      ),
    );
  }
}
