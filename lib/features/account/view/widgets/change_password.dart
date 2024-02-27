import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/common/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChangePassword extends HookWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();

    return InkWell(
      child: const Row(
        children: [
          Spacer(),
          Text(
            'Change password',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.key,
            color: Colors.white,
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
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 45, 15, 50),
                        Color.fromARGB(255, 87, 25, 98),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Change password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        softWrap: true,
                        'Please type in your current and new password.',
                        style: TextStyle(
                          color: Colors.white,
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
                                backgroundColor: Colors.green,
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
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(12),
                                  child: Wrap(
                                    children: [
                                      Center(
                                        child: Text(
                                          state.errorMessage,
                                          style: const TextStyle(
                                            color: Colors.white,
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
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              currentPasswordController.clear();
                              newPasswordController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
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
