// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputAction inputAction;
  final void Function()? callback;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.inputAction = TextInputAction.next,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(false);

    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            obscureText: !isPasswordVisible.value && icon == Icons.key,
            controller: controller,
            textInputAction: inputAction,
            cursorColor: Theme.of(context).colorScheme.primary,
            onSubmitted: (_) {
              if (callback != null) {
                callback!();
              }
            },
            keyboardType: labelText == 'Enter your email'
                ? TextInputType.emailAddress
                : TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
              ),
            ),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        if (icon == Icons.key)
          IconButton(
            onPressed: () {
              isPasswordVisible.value = !isPasswordVisible.value;
            },
            icon: Icon(
              isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
