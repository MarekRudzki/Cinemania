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
}
