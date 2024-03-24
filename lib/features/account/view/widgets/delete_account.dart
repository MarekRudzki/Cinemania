// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/custom_text_field.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/view/auth_screen.dart';

class DeleteAccount extends HookWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = useTextEditingController();

    return InkWell(
      child: Row(
        children: [
          const Spacer(),
          Text(
            'Delete account',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.delete_forever,
            color: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              color: Colors.transparent,
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.onBackground,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Are you sure?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        softWrap: true,
                        'This action will permanently delete your account. To continue provide current password.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 14,
                        ),
                      ),
                      BlocConsumer<AccountBloc, AccountState>(
                        listener: (context, state) {
                          if (state is AccountSuccess) {
                            passwordController.clear();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const AuthScreen(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackbar.showSnackBar(
                                message: 'Account deleted successfully',
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            );
                          }
                          if (state is AccountError) {
                            showModalBottomSheet(
                              context: context,
                              barrierColor: const Color.fromARGB(62, 3, 2, 2),
                              builder: (BuildContext context) {
                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                  },
                                );
                                return Container(
                                  color: Theme.of(context).colorScheme.error,
                                  padding: const EdgeInsets.all(12),
                                  child: Wrap(
                                    children: [
                                      Center(
                                        child: Text(
                                          state.errorMessage,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AccountLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              children: [
                                CustomTextField(
                                  controller: passwordController,
                                  labelText: 'Current password',
                                  icon: Icons.key,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<AccountBloc>().add(
                                    DeleteAccountPressed(
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            },
                            icon: Icon(
                              Icons.done,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              passwordController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 227, 86, 76),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
