import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  late final ThemeModeListener _listener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listener = ThemeModeListener(ref);
      WidgetsBinding.instance.addObserver(_listener);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.whiteBodyBg(Brightness.light),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: MainNavigation(),
    );
  }
}
