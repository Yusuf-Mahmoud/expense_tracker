import 'package:expense_tracker/features/addexpense/add_expense_screen.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is! ExpenseLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final balance = state.income - state.expense;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  AddExpenseScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Account Balance',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '\$${balance.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildCard(
                      'Income',
                      state.income,
                      Colors.green,
                    ),
                    const SizedBox(width: 10),
                    _buildCard(
                      'Expenses',
                      state.expense,
                      Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      final e = state.expenses[index];
                      return ListTile(
                        title: Text(e.title),
                        subtitle: Text(e.category),
                        trailing: Text(
                          e.isIncome
                              ? '+\$${e.amount}'
                              : '-\$${e.amount}',
                          style: TextStyle(
                            color: e.isIncome
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        onLongPress: () {
                          context
                              .read<ExpenseCubit>()
                              .deleteExpense(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(String title, double value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title),
            Text(
              '\$${value.toStringAsFixed(0)}',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
