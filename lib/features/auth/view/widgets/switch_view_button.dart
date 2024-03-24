// Flutter imports:
import 'package:flutter/material.dart';

class SwitchViewButton extends StatelessWidget {
  final bool isLoginView;
  final Function() callback;

  const SwitchViewButton({
    super.key,
    required this.isLoginView,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginView ? 'Don\'t have an account?' : 'Already have an account?',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: callback,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text(
              isLoginView ? 'Register now' : 'Try login',
              style: const TextStyle(
                color: Color.fromARGB(255, 62, 19, 69),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
