import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          "assets/animations/music-splash.json",
          onLoaded: (p0) {
            Future.delayed(
              const Duration(milliseconds: 2800),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
