import 'package:cinemania/features/auth/view/widgets/custom_text_field.dart';
import 'package:cinemania/features/auth/view/widgets/password_reset.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:cinemania/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoginView = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    void clearControllers() {
      emailController.clear();
      passwordController.clear();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 62, 19, 69),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(
                      seconds: 3,
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is AuthSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.10,
                      ),
                      Text(
                        isLoginView.value ? 'Log In' : 'Register',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.10,
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Enter your email',
                        icon: Icons.email_outlined,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Enter your password',
                        obscure: true,
                        inputAction: TextInputAction.done,
                        icon: Icons.key,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLoginView.value
                                ? 'Don\'t have an account?'
                                : 'Already have an account?',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              clearControllers();
                              isLoginView.value = !isLoginView.value;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                isLoginView.value
                                    ? 'Register now'
                                    : 'Try login',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isLoginView.value)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const PasswordReset();
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: const Text(
                                  'Click here to reset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (isLoginView.value) {
                                  context.read<AuthBloc>().add(
                                        LoginButtonPressed(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                } else {
                                  context.read<AuthBloc>().add(
                                        RegisterButtonPressed(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.height * 0.045,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.teal,
                                ),
                                child: Center(
                                  child: Text(
                                    isLoginView.value ? 'Log In' : 'Register',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
