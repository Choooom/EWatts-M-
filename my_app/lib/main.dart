import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:my_app/constants/route_observer.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/services/auth/auth_gate.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://oriehcqhdssqbicduzto.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9yaWVoY3FoZHNzcWJpY2R1enRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3OTg5MTUsImV4cCI6MjA3MDM3NDkxNX0.DJ4LkEDgwSuPN5O7b_i_GCGkdayKv6YphNvCy8ct2pA",
  );

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
      navigatorObservers: [routeObserver],
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.whiteBodyBg(Brightness.light),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: AuthGate(),
    );
  }
}
