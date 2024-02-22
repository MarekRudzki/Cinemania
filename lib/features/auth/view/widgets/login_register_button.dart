import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginRegisterButton extends StatelessWidget {
  final bool isLoginView;
  final String email;
  final String password;

  const LoginRegisterButton({
    super.key,
    required this.isLoginView,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        } else {
          return InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (isLoginView) {
                context.read<AuthBloc>().add(
                      LoginButtonPressed(
                        email: email,
                        password: password,
                      ),
                    );
              } else {
                context.read<AuthBloc>().add(
                      RegisterButtonPressed(
                        email: email,
                        password: password,
                      ),
                    );
              }
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.40,
              height: MediaQuery.sizeOf(context).height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  isLoginView ? 'Log In' : 'Register',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 62, 19, 69),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
