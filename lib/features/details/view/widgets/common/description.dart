import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        description,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimLines: 4,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
        ),
        trimCollapsedText: ' Read more',
        trimExpandedText: ' Show less',
        moreStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(55, 164, 94, 1),
        ),
        lessStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(55, 164, 94, 1),
        ),
      ),
    );
  }
}
