import 'package:cinemania/common/enums.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Category category;
  final int id;

  const DetailsScreen({
    super.key,
    required this.category,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id.toString()),
      ),
      body: const Placeholder(),
    );
  }
}
