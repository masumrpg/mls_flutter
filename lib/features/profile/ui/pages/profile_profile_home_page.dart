import 'package:flutter/material.dart';

class ProfileProfileHomePage extends StatelessWidget {
  const ProfileProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile ProfileHome'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Profile ProfileHome Page'),
        ),
      ),
    );
  }
}
