import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final String? username;

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.error,
    this.username,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
    String? username,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      username: username ?? this.username,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isLoading: false)) {
    _initializeAuth();
  }

  /// Initializes the authentication state
  Future<void> _initializeAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final username = prefs.getString('username');

      state = state.copyWith(
        isLoggedIn: isLoggedIn,
        username: username,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize authentication: ${e.toString()}',
      );
    }
  }

  /// Handles user login with basic validation and SharedPreferences storage
  Future<bool> login(String username, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // Basic validation
      if (username.isEmpty || password.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'Username and password are required',
        );
        return false;
      }

      // Simulate network call (Replace with actual API call)
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);

      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        username: username,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to login: ${e.toString()}',
      );
      return false;
    }
  }

  /// Logs out the user and clears SharedPreferences
  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      state = AuthState(isLoading: false); // Reset state after logout
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to logout: ${e.toString()}',
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
