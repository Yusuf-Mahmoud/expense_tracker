import 'package:expense_tracker/core/SharedPreferences/shared_preferences.dart';
import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/Onboarding/onboarding.dart';
import 'package:expense_tracker/features/auth/login/login_screen.dart';
import 'package:expense_tracker/features/home/home_screen.dart';
import 'package:expense_tracker/features/pin/enter_pin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Widget getStartScreen({
  required bool onBoardingDone,
  required bool isLoggedIn,
  required bool hasPin,
}) {
  if (!isLoggedIn && !onBoardingDone) {
    return const OnBoarding();
  }

  if (!isLoggedIn) {
    return const LoginScreen();
  }

  if (hasPin) {
    return const EnterPinScreen();
  }

  return const HomeScreen();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final onBoardingDone = await AppPrefs.isOnBoardingDone();
    final hasPin = await AppPrefs.hasPin();
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    final startScreen = getStartScreen(
      onBoardingDone: onBoardingDone,
      isLoggedIn: isLoggedIn,
      hasPin: hasPin,
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => startScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormanager.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Spend Wise',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
