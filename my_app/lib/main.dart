import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:my_app/constants/route_observer.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authProvider.notifier).checkAuthOnStartup();

  // await Supabase.initialize(
  //   url: "https://oriehcqhdssqbicduzto.supabase.co",
  //   anonKey:
  //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9yaWVoY3FoZHNzcWJpY2R1enRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3OTg5MTUsImV4cCI6MjA3MDM3NDkxNX0.DJ4LkEDgwSuPN5O7b_i_GCGkdayKv6YphNvCy8ct2pA",
  // );

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
  String? _accessToken;
  AppLinks? _appLinks;
  StreamSubscription<Uri>? _sub;
  late final ThemeModeListener _listener;

  void _initDeepLinkListener() async {
    _appLinks = AppLinks();

    // Listen for links when the app is already running
    _sub = _appLinks!.uriLinkStream.listen(
      (Uri uri) {
        _handleLink(uri);
      },
      onError: (err) {
        debugPrint("Error listening to link stream: $err");
      },
    );

    // Handle initial (cold start) link
    try {
      final initialUri = await _appLinks!.getInitialLink();
      if (initialUri != null) {
        _handleLink(initialUri);
      }
    } on Exception catch (e) {
      debugPrint("Failed to get initial uri: $e");
    }
  }

  void _handleLink(Uri uri) {
    if (uri.scheme == 'ewatts' && uri.host == 'oauth') {
      final success = uri.queryParameters['success'] == 'true';
      final accessToken = uri.queryParameters['access_token'];
      final refreshToken = uri.queryParameters['refresh_token'];

      setState(() {
        _accessToken = accessToken;
      });

      debugPrint("Success: $success");
      debugPrint("Access Token: $accessToken");
      debugPrint("Refresh Token: $refreshToken");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_listener);
    _sub?.cancel();
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
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isLoading) {
      return const Scaffold(
        body: Stack(children: [MainNavigation(), CircularProgressIndicator()]),
      );
    }

    if (authState.isAuthenticated) {
      return const MainNavigation();
    } else {
      return const LogIn();
    }
  }
}
