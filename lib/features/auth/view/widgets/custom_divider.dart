import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final BoxConstraints constraints;

  const CustomDivider({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2.0,
          width: constraints.maxWidth * 0.35,
          color: Colors.grey.shade600,
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Or',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          height: 2.0,
          width: constraints.maxWidth * 0.35,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }
}
