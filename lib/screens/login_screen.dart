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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF3D8FEF).withOpacity(0.8),
              const Color(0xFFF9FBFF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.screenHeight - MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(24),
                  vertical: context.responsiveSize(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.responsiveSize(60)),
                      // Logo
                      Center(
                        child: Container(
                          width: context.responsiveSize(120),
                          height: context.responsiveSize(120),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'asset/images/desiznideaz_logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.responsiveSize(40)),
                      // Login Text
                      Text(
                        'Login',
                        style: context.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: context.responsiveSize(28),
                        ),
                      ),
                      SizedBox(height: context.responsiveSize(40)),
                      // Login Form Container
                      Container(
                        padding: EdgeInsets.all(context.responsiveSize(24)),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
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
                              style: TextStyle(fontSize: context.responsiveSize(14)),
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: context.responsiveSize(14),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                            ),
                            SizedBox(height: context.responsiveSize(24)),
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              validator: _validatePassword,
                              obscureText: true,
                              style: TextStyle(fontSize: context.responsiveSize(14)),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: context.responsiveSize(14),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    // TODO: Implement forgot password
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: context.responsiveSize(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: context.responsiveSize(24)),
                            // Remember Me and Login Button
                            Row(
                              children: [
                                SizedBox(
                                  height: context.responsiveSize(24),
                                  width: context.responsiveSize(24),
                                  child: Checkbox(
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
                                ),
                                SizedBox(width: context.responsiveSize(8)),
                                Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: context.responsiveSize(12),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: authState.isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.responsiveSize(24),
                                      vertical: context.responsiveSize(12),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        context.responsiveSize(20),
                                      ),
                                    ),
                                  ),
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
                                          style: TextStyle(
                                            fontSize: context.responsiveSize(14),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Social Login Buttons
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Or sign in with',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: context.responsiveSize(12),
                              ),
                            ),
                            SizedBox(height: context.responsiveSize(16)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialButton(
                                  icon: Icons.g_mobiledata_rounded,
                                  onTap: () {
                                    // TODO: Implement Google sign in
                                  },
                                ),
                                SizedBox(width: context.responsiveSize(16)),
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
                      SizedBox(height: context.responsiveSize(32)),
                    ],
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
      borderRadius: BorderRadius.circular(context.responsiveSize(12)),
      child: Container(
        padding: EdgeInsets.all(context.responsiveSize(12)),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(context.responsiveSize(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: context.responsiveSize(24),
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
