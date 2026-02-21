import 'package:flutter/material.dart';

class HadisPage extends StatelessWidget {
  const HadisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadis'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Hadis Page'),
        ),
      ),
    );
  }
}
