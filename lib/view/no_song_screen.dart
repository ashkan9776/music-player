import 'package:flutter/material.dart';

class NoSongScreen extends StatelessWidget {
  const NoSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "No any song :(",
          style: TextStyle(fontSize: 15, fontFamily: 'lalezar'),
        ),
      ),
    );
  }
}
