import 'package:expense_tracker/core/SharedPreferences/shared_preferences.dart';
import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  String enteredPin = '';
  bool isError = false;

  void onNumberTap(String number) {
    if (enteredPin.length < 4) {
      setState(() {
        enteredPin += number;
        isError = false;
      });

      if (enteredPin.length == 4) {
        verifyPin();
      }
    }
  }

  void onDelete() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  Future<void> verifyPin() async {
    final savedPin = await AppPrefs.getPin();

    if (enteredPin == savedPin) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      setState(() {
        isError = true;
        enteredPin = '';
      });
    }
  }

  Widget pinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: index < enteredPin.length
                ? (isError ? Colors.red : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isError ? Colors.red : Colors.white,
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  Widget pinButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget pinKeyboard() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              if (key.isEmpty) return const SizedBox(width: 70);
              if (key == '⌫') {
                return pinButton(key, onDelete);
              }
              return pinButton(key, () => onNumberTap(key));
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormanager.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Enter PIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            pinDots(),
            if (isError)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Wrong PIN',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 40),
            pinKeyboard(),
          ],
        ),
      ),
    );
  }
}
