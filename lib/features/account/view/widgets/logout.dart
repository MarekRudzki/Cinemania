import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Row(
        children: [
          Spacer(),
          Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ],
      ),
      onTap: () {
        context.read<AccountBloc>().logout();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ),
        );
      },
    );
  }
}
