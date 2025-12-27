import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/widget/appheader.dart';
import 'package:expense_tracker/features/home/widget/navitem.dart';
import 'package:expense_tracker/features/home/widget/timecon.dart';
import 'package:expense_tracker/features/home/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/addexpense/add_expense_screen.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                AppHeader(balance, state.income, state.expense),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Spend Frequency",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colormanager.primaryViolet.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.show_chart,
                            size: 50,
                            color: Colormanager.primaryViolet,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildTimeFilter(),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent Transaction",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
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
                        physics: const NeverScrollableScrollPhysics(),
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
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colormanager.primaryViolet,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddExpenseScreen()),
              );
            },
            child: const Icon(Icons.add, color: Colors.white, size: 35),
          ),
          bottomNavigationBar: buildBottomAppBar(),
        );
      },
    );
  }
}
