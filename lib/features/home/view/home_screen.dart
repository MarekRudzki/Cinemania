import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/5625/5625453.png'),
    );
  }
}
