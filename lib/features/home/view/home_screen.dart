import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
        child: const SingleChildScrollView(
          child: Column(
            children: [
              Placeholder(
                strokeWidth: double.infinity,
                fallbackHeight: 200,
              ),
              // TextButton(
              //     onPressed: () {
              //       context.read<HomeBloc>().add(FetchMovieGenresPressed());
              //     },
              //     child: const Text('test1')),
              // TextButton(
              //     onPressed: () {
              //       context.read<HomeBloc>().add(FetchTVShowGenresPressed());
              //     },
              //     child: const Text('test2'))
            ],
          ),
        ),
      ),
    );
  }
}
