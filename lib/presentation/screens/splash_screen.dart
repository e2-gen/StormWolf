import 'package:flutter/material.dart';
import 'package:stormwolf/core/utils/auth_helper.dart';
import 'package:stormwolf/presentation/screens/auth/login_screen.dart';
import 'package:stormwolf/presentation/screens/main_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final authHelper = AuthHelper();
    final isLoggedIn = await authHelper.isUserLoggedIn();
    final hasRegistered = await authHelper.hasUserRegistered();

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (_) => const MainApp()));
    } else if (hasRegistered) {
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (_) => const RegisterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'POWER TRAINING',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Spacer(),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}