import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_controller.page!.toInt() < onboardingContents.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _onSkipPressed() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 100, top: 10),
        child: PageView.builder(
          controller: _controller,
          itemCount: onboardingContents.length,
          itemBuilder: (context, index) {
            final content = onboardingContents[index];
            return Container(
              color: index % 2 == 0 ? Colors.white : Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 1),
                    builder: (context, double opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        child: child,
                      );
                    },
                    child: Image.asset(content.image),
                  ),
                  const SizedBox(height: 15),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 50, end: 0),
                    duration: const Duration(seconds: 1),
                    builder: (context, double offset, child) {
                      return Transform.translate(
                        offset: Offset(0, offset),
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        content.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.blue.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: _onSkipPressed, child: const Text("Skip")),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: onboardingContents.length,
                effect: WormEffect(
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade300,
                ),
              ),
            ),
            TextButton(onPressed: _onNextPressed, child: const Text("Next")),
          ],
        ),
      ),
    );
  }
}
