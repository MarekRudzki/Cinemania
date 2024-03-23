// Flutter imports:
import 'package:flutter/material.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/no_network.png'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
              ),
              const Text(
                'No network connection',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 25,
                    ),
                    Shadow(
                      blurRadius: 25,
                    ),
                    Shadow(
                      blurRadius: 25,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Please turn on Internet and application will refresh',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 25,
                      ),
                      Shadow(
                        blurRadius: 25,
                      ),
                      Shadow(
                        blurRadius: 25,
                      ),
                    ],
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
