import 'package:flutter/widgets.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/5625/5625453.png'),
    );
  }
}
