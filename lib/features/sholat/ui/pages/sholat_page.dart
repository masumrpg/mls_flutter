import 'package:flutter/material.dart';

class SholatPage extends StatelessWidget {
  const SholatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sholat'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Sholat Page'),
        ),
      ),
    );
  }
}
