import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picshare_app/presentation/widgets/button_fill.dart';
import 'package:picshare_app/presentation/widgets/button_stroke.dart';
import 'package:picshare_app/presentation/widgets/onboarding_content.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final tertiary = Theme.of(context).colorScheme.tertiary;
    final List<Widget> _pages = [
      OnboardingContent(
        imagePath: 'assets/images/Image upload-bro.png',
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Snap',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? primary
                        : tertiary),
              ),
              TextSpan(
                text: '. Share. Inspire.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        subtitle:
            'Effortlessly upload your moments and keep them beautifully organized.',
      ),
      OnboardingContent(
        imagePath: 'assets/images/Photo Sharing-rafiki.png',
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'See what others ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextSpan(
                text: 'share',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? primary
                        : tertiary),
              ),
              TextSpan(
                text: '.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        subtitle: 'Get inspired by photos shared by people across the globe.',
      ),
      OnboardingContent(
        imagePath: 'assets/images/Online world-bro.png',
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Connect Moments to ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextSpan(
                text: 'Places',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? primary
                        : tertiary),
              ),
              TextSpan(
                text: '.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        subtitle:
            'See where memories are made and find snapshots near and far.',
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CarouselSlider(
                items: _pages,
                carouselController: _controller,
                options: CarouselOptions(
                  height: 500,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _pages.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _currentIndex == entry.key ? 32 : 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == entry.key
                        ? Theme.of(context).colorScheme.primary
                        : Color(0xFFD9D9D9),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            ButtonFill(
              text: 'LOGIN',
              action: () => context.push('/login'),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonStroke(
              text: 'REGISTER',
              action: () => context.push('/register'),
            )
          ],
        ),
      ),
    );
  }
}
