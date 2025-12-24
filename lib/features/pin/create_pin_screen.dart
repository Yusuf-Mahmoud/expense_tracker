import 'package:expense_tracker/core/SharedPreferences/shared_preferences.dart';
import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String pin = '';

  void onNumberTap(String number) {
    if (pin.length < 4) {
      setState(() {
        pin += number;
      });
    }
  }

  void onDelete() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  Future<void> savePin() async {
    if (pin.length == 4) {
      await AppPrefs.savePin(pin);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
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
              'Create PIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            pinDots(pin),
            const SizedBox(height: 40),
            pinKeyboard(
              onNumberTap: onNumberTap,
              onDelete: onDelete,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: pin.length == 4 ? savePin : null,
              child: const Text('Confirm PIN'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
Widget pinDots(String pin) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(4, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: index < pin.length ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: 2),
        ),
      );
    }),
  );
}
Widget pinButton({
  required String text,
  required VoidCallback onTap,
}) {
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
Widget pinKeyboard({
  required Function(String) onNumberTap,
  required VoidCallback onDelete,
}) {
  return Column(
    children: [
      for (var row in [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
        ['', '0', '⌫'],
      ])
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((item) {
              if (item.isEmpty) return const SizedBox(width: 70);
              if (item == '⌫') {
                return pinButton(
                  text: item,
                  onTap: onDelete,
                );
              }
              return pinButton(
                text: item,
                onTap: () => onNumberTap(item),
              );
            }).toList(),
          ),
        ),
    ],
  );
}
