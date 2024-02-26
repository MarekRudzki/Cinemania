import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconColor: Colors.white,
      color: const Color.fromARGB(255, 87, 25, 98),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Change display name',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Change password',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Delete account',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
          ),
        ];
      },
    );
  }
}
