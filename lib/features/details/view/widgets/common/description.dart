// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:readmore/readmore.dart';

class Description extends StatelessWidget {
  final String description;

  const Description({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ReadMoreText(
        description,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimLines: 4,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        trimCollapsedText: ' Read more',
        trimExpandedText: ' Show less',
        moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        lessStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
