import 'package:flutter/material.dart';

class ColorManager {
  // الألوان الأساسية
  static const Color primaryViolet = Color(0xFF7F3DFF);
  static const Color lightViolet = Color(0xFFEEE5FF);
  
  // ألوان الحالة (المالية)
  static const Color incomeGreen = Color(0xFF00A86B);
  static const Color lightGreen = Color(0xFFCFFAEA);
  static const Color expenseRed = Color(0xFFFD3C4A);
  static const Color lightRed = Color(0xFFFDD5D7);

  // ألوان الخلفية والنصوص
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0D0E0F);
  static const Color grey = Color(0xFF91919F);
  static const Color lightGrey = Color(0xFFF1F1FA);
  
  // ألوان إضافية للأقسام (Categories)
  static const Color yellow = Color(0xFFFCAC12);
  static const Color blue = Color(0xFF0077FF);
}


class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: ColorManager.primaryViolet,
      scaffoldBackgroundColor: ColorManager.white,
      
      // تنسيق النصوص
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ColorManager.black),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorManager.black),
        bodyMedium: TextStyle(fontSize: 16, color: ColorManager.black),
        bodySmall: TextStyle(fontSize: 13, color: ColorManager.grey),
      ),

      // تنسيق الأزرار (مثل زر إضافة مصروف)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryViolet,
          foregroundColor: ColorManager.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

    

      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorManager.black),
        titleTextStyle: TextStyle(color: ColorManager.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );

  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorManager.primaryViolet,
      scaffoldBackgroundColor: const Color(0xFF161719), 
      cardColor: const Color(0xFF212325),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }
}