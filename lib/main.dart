import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_screen.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Design Ideaz App',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: SafeArea(child: child ?? const SizedBox.shrink()),
        );
      },
      home: authState.isLoggedIn ? const BaseScreen() : const LoginScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE53935),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          iconTheme: IconThemeData(color: Color(0xFFE53935)),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Color(0xFFE53935),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1E1E1E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE53935),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          iconColor: const Color(0xFFE53935),
          prefixIconColor: const Color(0xFFE53935),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE53935),
          secondary: Color(0xFFFF5252),
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF121212),
          error: Color(0xFFCF6679),
        ),
      ),
    );
  }
}

extension ResponsiveExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double responsiveSize(double size) => screenHeight * (size / 1000);
  TextStyle? get textSmall => Theme.of(this).textTheme.titleLarge;
  TextStyle? get textMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get textLarge => Theme.of(this).textTheme.displayMedium;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
