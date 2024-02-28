import 'package:cinemania/features/search/view/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              const CustomSearchBar(),
              Divider(
                endIndent: 30,
                indent: 30,
                color: Colors.grey.shade600,
                thickness: 2,
              ),
              const SizedBox(
                width: double.infinity,
                height: 800,
              )
            ],
          ),
        ),
      ),
    );
  }
}
