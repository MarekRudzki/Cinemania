// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/custom_text_field.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';

class PasswordReset extends HookWidget {
  final void Function() startCallback;
  final void Function() endCallback;

  const PasswordReset({
    super.key,
    required this.startCallback,
    required this.endCallback,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: const Text(
              'Forget password?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          onPressed: () {
            startCallback();
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
                            Theme.of(context).colorScheme.surface,
                            Theme.of(context).colorScheme.onSurface,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Reset your password?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            softWrap: true,
                            'Enter the email adress associated with your account.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                            ),
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                emailController.clear();

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbar.showSnackBar(
                                    message:
                                        'You should find link to reset your password in your mailbox.',
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                );
                              }
                              if (state is AuthError) {
                                showModalBottomSheet(
                                  context: context,
                                  barrierColor:
                                      const Color.fromARGB(62, 3, 2, 2),
                                  builder: (BuildContext context) {
                                    Future.delayed(
                                      const Duration(seconds: 3),
                                      () {
                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                      },
                                    );
                                    return Container(
                                      color:
                                          Theme.of(context).colorScheme.error,
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
                              if (state is AuthLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Column(
                                  children: [
                                    CustomTextField(
                                      controller: emailController,
                                      labelText: 'Input your email',
                                      inputAction: TextInputAction.done,
                                      icon: Icons.person,
                                      callback: () {
                                        context.read<AuthBloc>().add(
                                              PasswordResetPressed(
                                                passwordResetEmail:
                                                    emailController.text.trim(),
                                              ),
                                            );
                                      },
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
                                  context.read<AuthBloc>().add(
                                        PasswordResetPressed(
                                          passwordResetEmail:
                                              emailController.text.trim(),
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
                                  emailController.clear();
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
            ).then((_) {
              endCallback();
            });
          },
        ),
      ],
    );
  }
}
