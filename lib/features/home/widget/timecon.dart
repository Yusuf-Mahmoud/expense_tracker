import 'package:flutter/material.dart';

Widget buildTimeFilter() {
    final filters = ["Today", "Week", "Month", "Year"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filters.map((f) {
        bool isSelected = f == "Today";
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFCEED4) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            f,
            style: TextStyle(
              color: isSelected ? const Color(0xFFFCAC12) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }