import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/core/widget/customauthbutton.dart';
import 'package:expense_tracker/features/Onboarding/widget/on_boarding_item.dart';
import 'package:expense_tracker/features/auth/login/login_screen.dart';
import 'package:expense_tracker/features/auth/signup/signup_screen.dart';
import 'package:expense_tracker/core/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                OnBoardingItem(
                  image: 'assets/images/PageView.png',
                  title: 'Gain total control of your money',
                  subTitle:
                      'Become your own money manager and make every cent count',
                ),
                OnBoardingItem(
                  image: 'assets/images/PageView2.png',
                  title: 'Know where your money goes',
                  subTitle:
                      'Track your transaction easily, with categories and financial report',
                ),
                OnBoardingItem(
                  image: 'assets/images/PageView3.png',
                  title: 'Planning ahead',
                  subTitle:
                      'Setup your budget for each category and be notified when you\'re close to hitting them',
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          CustomAuthButton(
            text: 'Sign UP',
            backgroundColor: ColorManager.primaryViolet,
            textColor: Colors.white,
            onPressed: () {
              AppPrefs.setOnBoardingDone();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignupScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          CustomAuthButton(
            text: 'Login',
            backgroundColor: Colors.deepPurple.shade50,
            textColor: ColorManager.primaryViolet,
            onPressed: () {
              AppPrefs.setOnBoardingDone();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}
