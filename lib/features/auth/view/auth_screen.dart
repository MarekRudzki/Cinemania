import 'package:cinemania/features/auth/view/widgets/custom_divider.dart';
import 'package:cinemania/features/auth/view/widgets/custom_text_field.dart';
import 'package:cinemania/features/auth/view/widgets/login_register_button.dart';
import 'package:cinemania/features/auth/view/widgets/password_reset.dart';
import 'package:cinemania/features/auth/view/widgets/social_media_button.dart';
import 'package:cinemania/features/auth/view/widgets/switch_view_button.dart';
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 62, 19, 69),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                print(state.errorMessage);
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
                        height: constraints.maxHeight * 0.07,
                      ),
                      Text(
                        isLoginView.value ? 'Log In' : 'Register',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.07,
                      ),
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
                      if (isLoginView.value) const PasswordReset(),
                      const SizedBox(height: 8),
                      LoginRegisterButton(
                        isLoginView: isLoginView.value,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
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
    );
  }
}
