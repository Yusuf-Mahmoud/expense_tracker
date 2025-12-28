import 'package:expense_tracker/core/constants/categories.dart';
import 'package:expense_tracker/core/model/category_model.dart';
import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildTransactionItem(ExpenseModel e, BuildContext context, int index) {
  final categoryData = expenseCategories.firstWhere(
    (cat) => cat.name == e.category,
    orElse: () =>
        ExpenseCategory(name: 'Other', icon: Icons.money, color: Colors.grey),
  );

  final IconData displayIcon = e.isIncome
      ? Icons.account_balance_wallet
      : categoryData.icon;
  final Color displayColor = e.isIncome
      ? Colormanager.incomeGreen
      : categoryData.color;

  return InkWell(
    onDoubleTap: () => context.read<ExpenseCubit>().deleteExpense(index),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: displayColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(displayIcon, color: displayColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  e.isIncome ? "Income" : "Expense",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${e.isIncome ? "+" : "-"}\$${e.amount.toStringAsFixed(0)}",
                style: TextStyle(
                  color: e.isIncome
                      ? Colormanager.incomeGreen
                      : Colormanager.expenseRed,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${e.date.hour}:${e.date.minute.toString().padLeft(2, '0')} ${e.date.hour >= 12 ? 'PM' : 'AM'}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
