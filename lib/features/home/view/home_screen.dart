import 'package:cinemania/features/home/view/widgets/home_category_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color.fromARGB(255, 45, 15, 50),
              Color.fromARGB(255, 87, 25, 98),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: HomeCategoryPicker(
            callback: () {},
          ),
        ),
      ),
    );
  }
}
