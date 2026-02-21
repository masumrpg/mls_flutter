import 'package:flutter/material.dart';

class HadisPage extends StatelessWidget {
  const HadisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadis'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Hadis Page'),
        ),
      ),
    );
  }
}
