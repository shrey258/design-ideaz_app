import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../main.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                          MediaQuery.of(context).padding.top - 
                          MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSize(24),
                    vertical: context.responsiveSize(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Text with theme styling
                        Text(
                          'Welcome Back',
                          style: context.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.responsiveSize(12)),
                        Text(
                          'Sign in to continue',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        SizedBox(height: context.responsiveSize(40)),
                        // Login Form Container
                        Container(
                          padding: EdgeInsets.all(context.responsiveSize(24)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Username Field
                              TextFormField(
                                controller: _usernameController,
                                validator: _validateUsername,
                                style: context.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: context.responsiveSize(24)),
                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                validator: _validatePassword,
                                obscureText: true,
                                style: context.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: TextButton(
                                    onPressed: () {
                                      // TODO: Implement forgot password
                                    },
                                    child: Text(
                                      'Forgot?',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: context.responsiveSize(24)),
                              // Remember Me checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Text(
                                    'Remember Me',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: context.responsiveSize(32)),
                              // Sign In Button
                              SizedBox(
                                width: double.infinity,
                                height: context.responsiveSize(54),
                                child: ElevatedButton(
                                  onPressed: authState.isLoading ? null : _handleLogin,
                                  child: authState.isLoading
                                      ? SizedBox(
                                          width: context.responsiveSize(20),
                                          height: context.responsiveSize(20),
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'Sign In',
                                          style: context.textTheme.titleLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.responsiveSize(40)),
                        // Social Login
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Or sign in with',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: context.responsiveSize(20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _socialButton(
                                    icon: Icons.g_mobiledata_rounded,
                                    onTap: () {
                                      // TODO: Implement Google sign in
                                    },
                                  ),
                                  SizedBox(width: context.responsiveSize(20)),
                                  _socialButton(
                                    icon: Icons.apple_rounded,
                                    onTap: () {
                                      // TODO: Implement Apple sign in
                                    },
                                    isDark: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isDark = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.responsiveSize(16)),
      child: Container(
        padding: EdgeInsets.all(context.responsiveSize(16)),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: context.responsiveSize(28),
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref.read(authProvider.notifier).login(
            _usernameController.text,
            _passwordController.text,
          );
      
      if (success && mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      } else if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ref.read(authProvider).error ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
