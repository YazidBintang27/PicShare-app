import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picshare_app/providers/splash/splash_provider.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final String? token = Provider.of<SplashProvider>(context).token;
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        context.go('/main');
      } else {
        context.go('/onboarding');
      }
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
