import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String imagePath;
  final Widget title;
  final String subtitle;
  const OnboardingContent(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            imagePath,
          ),
          title,
          const SizedBox(height: 8,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
