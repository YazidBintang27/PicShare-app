import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/onboarding');
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/PicShare.png',
          width: 160,
          height: 160,
        ),
      ),
    );
  }
}
