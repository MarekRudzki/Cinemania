import 'package:cinemania/features/auth/view/widgets/custom_divider.dart';
import 'package:cinemania/common/custom_text_field.dart';
import 'package:cinemania/features/auth/view/widgets/login_register_button.dart';
import 'package:cinemania/features/auth/view/widgets/password_reset.dart';
import 'package:cinemania/features/auth/view/widgets/social_media_button.dart';
import 'package:cinemania/features/auth/view/widgets/switch_view_button.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:cinemania/features/main/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoginView = useState(true);
    final isForgotPasswordView = useState(false);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.onBackground,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading && !isForgotPasswordView.value) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Dialog.fullscreen(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else if (state is AuthError && !isForgotPasswordView.value) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(
                        seconds: 3,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else if (state is AuthSuccess &&
                    !isForgotPasswordView.value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
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
                          height: constraints.maxHeight * 0.07,
                        ),
                        Image.asset('assets/auth_icon.png'),
                        SizedBox(
                          height: constraints.maxHeight * 0.07,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: emailController,
                                labelText: 'Enter your email',
                                icon: Icons.email_outlined,
                              ),
                              CustomTextField(
                                controller: passwordController,
                                labelText: 'Enter your password',
                                inputAction: TextInputAction.done,
                                icon: Icons.key,
                              ),
                            ],
                          ),
                        ),
                        if (isLoginView.value)
                          PasswordReset(
                            startCallback: () =>
                                isForgotPasswordView.value = true,
                            endCallback: () =>
                                isForgotPasswordView.value = false,
                          ),
                        const SizedBox(height: 8),
                        LoginRegisterButton(
                          isLoginView: isLoginView.value,
                          onTap: () {
                            if (isLoginView.value) {
                              context.read<AuthBloc>().add(
                                    LoginButtonPressed(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            } else {
                              context.read<AuthBloc>().add(
                                    RegisterButtonPressed(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                        CustomDivider(constraints: constraints),
                        SocialMediaButton(
                          imagePath: 'assets/google_icon.png',
                          buttonText: 'Sign in with Google',
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  LoginWithGooglePressed(),
                                );
                          },
                        ),
                        SocialMediaButton(
                          imagePath: 'assets/facebook_icon.png',
                          buttonText: 'Sign in with Facebook',
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  LoginWithFacebookPressed(),
                                );
                          },
                        ),
                        const SizedBox(height: 10),
                        SwitchViewButton(
                          isLoginView: isLoginView.value,
                          callback: () {
                            emailController.clear();
                            passwordController.clear();

                            isLoginView.value = !isLoginView.value;
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
