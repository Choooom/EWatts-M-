import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_app/widgets/onboarding_one.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF25262A), Color(0xFF848482)],
          ),
        ),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(title: "Welcome", bodyWidget: OnBoardingPageOne()),
            PageViewModel(
              title: "Welcome",
              body: "This is an onboarding screen.",
              image: Center(child: Icon(Icons.android, size: 100)),
            ),
            PageViewModel(
              title: "Welcome",
              body: "This is an onboarding screen.",
              image: Center(child: Icon(Icons.android, size: 100)),
            ),
          ],
          done: const Text("Done"),
          onDone: () {
            // Navigate to main app
          },
          showSkipButton: true,
          skip: const Text("Skip"),
          next: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
