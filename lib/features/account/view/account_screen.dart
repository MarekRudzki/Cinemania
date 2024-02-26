import 'package:cinemania/features/account/view/widgets/custom_popup_menu.dart';
import 'package:cinemania/features/account/view/widgets/favorites.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      context.read<AccountBloc>().getUsername(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    const CustomPopupMenu(),
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
