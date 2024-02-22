import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordReset extends HookWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    textAlign: TextAlign.center,
                    'Reset your password?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  content: const Text(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    'Enter the email adress associated with your account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                  actions: [
                    Column(
                      children: [
                        TextField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            label: const Center(
                              child: Text('Input your email'),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state is AuthError
                                  ? Text(
                                      state.errorMessage,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            );
                          },
                        ),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              Navigator.of(context).pop();
                              emailController.clear();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Check your mailbox',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    content: const Text(
                                      'You should find link to reset your password in your mailbox.',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    backgroundColor: Colors.teal,
                                    actions: [
                                      Center(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      context.read<AuthBloc>().add(
                                          PasswordResetPressed(
                                              passwordResetEmail:
                                                  emailController.text.trim()));
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      emailController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
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
        ),
      ],
    );
  }
}
