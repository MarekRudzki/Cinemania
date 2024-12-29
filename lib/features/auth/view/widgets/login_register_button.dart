// Flutter imports:
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final bool isLoginView;
  final void Function() onTap;

  const LoginRegisterButton({
    super.key,
    required this.isLoginView,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              isLoginView ? 'Log In' : 'Register',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
