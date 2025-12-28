import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/widget/appheader.dart';
import 'package:expense_tracker/features/home/widget/navitem.dart';
import 'package:expense_tracker/features/home/widget/timecon.dart';
import 'package:expense_tracker/features/home/widget/transaction_item.dart';
import 'package:expense_tracker/features/moneyflow/add_income_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/moneyflow/add_expense_screen.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFabOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is! ExpenseLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final balance = state.income - state.expense;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                appheader(balance, state.income, state.expense),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: 20),
                       Text(
                        "Spend Frequency",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colormanager.primaryViolet.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:  Center(
                          child: Icon(
                            Icons.show_chart,
                            size: 50,
                            color: Colormanager.primaryViolet,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildTimeFilter(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            "Recent Transaction",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child:  Text(
                              "See All",
                              style: TextStyle(
                                color: Colormanager.primaryViolet,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: state.expenses.length,
                        itemBuilder: (context, index) {
                          final transaction = state.expenses[index];
                          return buildTransactionItem(
                            transaction,
                            context,
                            index,
                          );
                        },
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            width: 130,
            height: 220,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: isFabOpen ? 140 : 0,
                  child: AnimatedOpacity(
                    opacity: isFabOpen ? 1 : 0,
                    duration:  Duration(milliseconds: 300),
                    child: FloatingActionButton(
                      heroTag: 'expense',
                      mini: true,
                      backgroundColor: Colormanager.expenseRed,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddExpenseScreen(),
                          ),
                        );
                      },
                      child:  Icon(Icons.trending_down_rounded),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration:  Duration(milliseconds: 300),
                  bottom: isFabOpen ? 80 : 0,
                  child: AnimatedOpacity(
                    opacity: isFabOpen ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: FloatingActionButton(
                      heroTag: 'income',
                      mini: true,
                      backgroundColor: Colormanager.incomeGreen,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddIncomeScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),

                FloatingActionButton(
                  heroTag: 'main',
                  backgroundColor: Colormanager.primaryViolet,
                  shape: const CircleBorder(),
                  onPressed: () {
                    setState(() {
                      isFabOpen = !isFabOpen;
                    });
                  },
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
          ),

          bottomNavigationBar: buildBottomAppBar(),
        );
      },
    );
  }
}
