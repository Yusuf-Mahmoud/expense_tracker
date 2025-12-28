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
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: displayColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(displayIcon, color: displayColor),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  e.category,
                  style:  TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${e.isIncome ? "+" : "-"}\$${e.amount}",
                style: TextStyle(
                  color: e.isIncome
                      ? Colormanager.incomeGreen
                      : Colormanager.expenseRed,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${e.date.hour}:${e.date.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
