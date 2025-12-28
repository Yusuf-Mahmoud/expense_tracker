import 'package:flutter/material.dart';

class RepeatSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const RepeatSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Repeat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text("Repeat transaction", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF7F3DFF),
        ),
      ],
    );
  }
}