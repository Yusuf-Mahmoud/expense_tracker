import 'package:expense_tracker/core/theme/theme.dart';
import 'package:flutter/material.dart';

Widget buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colormanager.primaryViolet : Colors.grey.shade400,
          size: 28,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colormanager.primaryViolet : Colors.grey.shade400,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
  Widget buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavItem(Icons.home_filled, "Home", true),
            buildNavItem(Icons.swap_horiz, "Transaction", false),
            const SizedBox(width: 40),
            buildNavItem(Icons.pie_chart, "Budget", false),
            buildNavItem(Icons.person, "Profile", false),
          ],
        ),
      ),
    );
  }