import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimation extends StatefulWidget {
  final String weatherCondition;

  const WeatherAnimation({super.key, required this.weatherCondition});

  @override
  State<WeatherAnimation> createState() => _WeatherAnimationState();
}

class _WeatherAnimationState extends State<WeatherAnimation>
    with SingleTickerProviderStateMixin {
  static final Map<String, LottieComposition> _cache = {};
  late final AnimationController _controller;

  Future<LottieComposition> _loadComposition(String condition) async {
    if (_cache.containsKey(condition)) {
      return _cache[condition]!;
    }

    final path = _getAnimationPath(condition);
    final composition = await AssetLottie(path).load();
    _cache[condition] = composition;
    return composition;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Slower animation
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getAnimationPath(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return 'assets/animations/weather_sunny.json';
      case 'partly sunny':
        return 'assets/animations/weather_partly_sunny.json';
      case 'partly shower':
        return 'assets/animations/weather_partly_shower.json';
      case 'windy':
        return 'assets/animations/weather_windy.json';
      case 'storm':
        return 'assets/animations/weather_storm.json';
      case 'cloudy night':
        return 'assets/animations/weather_cloudy_night.json';
      case 'rainy night':
        return 'assets/animations/weather_rainy_night.json';
      default:
        return 'assets/animations/weather_partly_sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _loadComposition(widget.weatherCondition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else if (snapshot.hasData) {
          final composition = snapshot.data!;
          _controller.duration = composition.duration * 2;
          _controller.repeat();

          return Lottie(
            composition: composition,
            width: 80,
            height: 80,
            controller: _controller,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
