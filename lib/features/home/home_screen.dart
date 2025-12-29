import 'package:expense_tracker/features/home/home_content.dart';
import 'package:expense_tracker/features/home/transactions_page.dart';
import 'package:expense_tracker/features/home/moneyflow/add_expense_screen.dart';
import 'package:expense_tracker/features/home/moneyflow/add_income_screen.dart';
import 'package:expense_tracker/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFabOpen = false;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    TransactionsPage(),
    Center(child: Text("Budget Screen")),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _pages[_currentIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFabStack(),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_filled, "Home", 0),
              buildNavItem(Icons.swap_horiz, "Transaction", 1),
              SizedBox(width: 35),
              buildNavItem(Icons.pie_chart, "Budget", 2),
              buildNavItem(Icons.person, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? ColorManager.primaryViolet : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? ColorManager.primaryViolet : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFabStack() {
    return SizedBox(
      width: 130,
      height: 220,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: isFabOpen ? 140 : 0,
            child: AnimatedOpacity(
              opacity: isFabOpen ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: 'expense',
                mini: true,
                backgroundColor: ColorManager.expenseRed,
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => AddExpenseScreen()),
                  );
                },
                child: const Icon(
                  Icons.trending_down_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: isFabOpen ? 80 : 0,
            child: AnimatedOpacity(
              opacity: isFabOpen ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: 'income',
                mini: true,
                backgroundColor: ColorManager.incomeGreen,
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => AddIncomeScreen()),
                  );
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: 'main',
            backgroundColor: ColorManager.primaryViolet,
            shape: const CircleBorder(),
            onPressed: () => setState(() => isFabOpen = !isFabOpen),
            child: AnimatedRotation(
              turns: isFabOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFabOpen ? Icons.close : Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
