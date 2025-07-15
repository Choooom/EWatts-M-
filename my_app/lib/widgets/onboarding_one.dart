import 'package:flutter/material.dart';

class OnBoardingPageOne extends StatelessWidget {
  const OnBoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // full width
      height:
          MediaQuery.of(context).size.height * 0.4, // adjust height as needed
      child: Image.asset(
        'assets/images/on_boarding/first_pic.png',
        fit: BoxFit.fitWidth,
        color: const Color(0xFFD2ECF3),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }
}
