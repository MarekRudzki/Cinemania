// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/custom_text_field.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';

class ChangePassword extends HookWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();

    return InkWell(
      child: Row(
        children: [
          const Spacer(),
          Text(
            'Change password',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.key,
            color: Theme.of(context).colorScheme.primary,
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
                        'Change password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        softWrap: true,
                        'Please type in your current and new password.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                      BlocConsumer<AccountBloc, AccountState>(
                        listener: (context, state) {
                          if (state is AccountSuccess) {
                            currentPasswordController.clear();
                            newPasswordController.clear();

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackbar.showSnackBar(
                                message: 'Password changed successfully',
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
                                  controller: currentPasswordController,
                                  labelText: 'Current password',
                                  icon: Icons.key,
                                ),
                                CustomTextField(
                                  controller: newPasswordController,
                                  labelText: 'New password',
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
                                    ChangePasswordPressed(
                                      currentPassword:
                                          currentPasswordController.text.trim(),
                                      newPassword:
                                          newPasswordController.text.trim(),
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
                              currentPasswordController.clear();
                              newPasswordController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.error,
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
