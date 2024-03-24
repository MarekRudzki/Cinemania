// Flutter imports:
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final void Function() onTap;

  const SocialMediaButton({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Container(
          height: 45,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: [
              const SizedBox(width: 7),
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              const SizedBox(width: 7),
              const VerticalDivider(
                width: 5,
                thickness: 2.5,
                color: Color.fromARGB(255, 62, 19, 69),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 62, 19, 69),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
