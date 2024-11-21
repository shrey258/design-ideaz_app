import 'package:design_ideaz_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'base_screen.dart';

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
      theme: ThemeData(
        primaryColor: const Color(0xFF3D8FEF),
        scaffoldBackgroundColor: const Color(0xFFF9FBFF),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFF9FBFF),
          iconTheme: const IconThemeData(color: Color(0xFF3D8FEF)),
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF3D8FEF),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF37474F),
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF37474F),
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF37474F),
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF37474F),
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Color(0xFF37474F),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3D8FEF),
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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFFFFAB91), // Light peach accent color
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/': (context) => authState.isLoggedIn 
            ? const BaseScreen() 
            : const LoginScreen(),
        '/login': (context) => const LoginScreen(),
      },
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
