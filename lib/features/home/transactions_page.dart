import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';
import 'package:expense_tracker/features/home/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(context),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoaded) {
                      final expenses = state.expenses;

                      if (expenses.isEmpty) {
                        return Center(child: Text("No transactions found"));
                      }
                      final sortedExpenses = List.from(expenses)
                        ..sort((a, b) => b.date.compareTo(a.date));
                      return ListView.builder(
                        itemCount: sortedExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = sortedExpenses[index];
                          bool showHeader = false;
                          String headerText = "";

                          if (index == 0) {
                            showHeader = true;
                            headerText = _getHeaderText(expense.date);
                          } else {
                            final prevExpense = sortedExpenses[index - 1];
                            if (expense.date.day != prevExpense.date.day ||
                                expense.date.month != prevExpense.date.month) {
                              showHeader = true;
                              headerText = _getHeaderText(expense.date);
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showHeader)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    headerText,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              buildTransactionItem(expense, context, index),
                            ],
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<int>(
              onSelected: (months) {
                context.read<ExpenseCubit>().filterExpenses(
                  monthsLimit: months,
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 1, child: Text("Last Month")),
                const PopupMenuItem(value: 3, child: Text("Last 3 Months")),
                const PopupMenuItem(value: 6, child: Text("Last 6 Months")),
                const PopupMenuItem(value: 12, child: Text("Last Year")),
                const PopupMenuItem(value: null, child: Text("All Time")),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down),
                    SizedBox(width: 5),
                    Text("Filter Period"),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, size: 30),
              onPressed: () => _showCategoryFilter(context),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "See your financial report",
                style: TextStyle(
                  color: ColorManager.primaryViolet,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.chevron_right, color: ColorManager.primaryViolet),
            ],
          ),
        ),
      ],
    );
  }

  void _showCategoryFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final categories = [
          'All',
          'Bills',
          'Shopping',
          'Food',
          'Salary',
          'Transportation',
        ];
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filter by Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: categories.map((cat) {
                  return ActionChip(
                    label: Text(cat),
                    onPressed: () {
                      context.read<ExpenseCubit>().filterExpenses(
                        category: cat,
                      );
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getHeaderText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final expenseDate = DateTime(date.year, date.month, date.day);

    if (expenseDate == today) return "Today";
    if (expenseDate == yesterday) return "Yesterday";
    return "${date.day}/${date.month}/${date.year}";
  }
}
