import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/view/widgets/custom_text_field.dart';
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
            Icons.edit,
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
                title: const Text(
                  'Change password?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                content: const Text(
                  softWrap: true,
                  'Please type in your current and new password.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 87, 25, 98),
                actions: [
                  Column(
                    children: [
                      BlocConsumer<AccountBloc, AccountState>(
                        listener: (context, state) {
                          // if (state is ChangePasswordSuccess) {
                          //   currentPasswordController.clear();
                          //   newPasswordController.clear();
                          //   confirmedNewPasswordController.clear();
                          //   Navigator.of(context).pop();
                          //   ScaffoldMessenger.of(context).clearSnackBars();
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(CustomSnackbar.showSnackBar(
                          //     message: 'Password changed successfully',
                          //     backgroundColor: Colors.green,
                          //   ));
                          // }
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
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child:
                                        BlocListener<AccountBloc, AccountState>(
                                      listener: (context, state) {
                                        if (state is AccountError) {
                                          showModalBottomSheet(
                                            context: context,
                                            barrierColor: const Color.fromARGB(
                                                62, 3, 2, 2),
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                const Duration(seconds: 3),
                                                () {
                                                  if (!context.mounted) return;
                                                  Navigator.pop(context);
                                                },
                                              );
                                              return Container(
                                                color: const Color.fromARGB(
                                                    255, 87, 25, 98),
                                                padding:
                                                    const EdgeInsets.all(12),
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
                                    )),
                              ],
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // context
                              //     .read<ChangePasswordBloc>()
                              //     .add(ChangePasswordPressed(
                              //       currentPassword:
                              //           currentPasswordController.text.trim(),
                              //       newPassword: newPasswordController.text.trim(),
                              //       confirmedNewPassword:
                              //           confirmedNewPasswordController.text.trim(),
                              //     ));
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}
