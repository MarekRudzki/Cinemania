import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.inputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(false);

    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            obscureText: !isPasswordVisible.value && icon == Icons.key,
            controller: controller,
            textInputAction: inputAction,
            cursorColor: Colors.white,
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
              labelText: labelText,
              labelStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
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
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
