import 'package:flutter/material.dart';

class KalenderKalenderHomePage extends StatelessWidget {
  const KalenderKalenderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender KalenderHome')),
      body: const SafeArea(
        child: Center(child: Text('Kalender KalenderHome Page')),
      ),
    );
  }
}
