import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildTransactionItem(dynamic e, BuildContext context, int index) {
    return InkWell(
      onLongPress: () => context.read<ExpenseCubit>().deleteExpense(index),
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
                color:
                    (e.isIncome
                            ? Colormanager.incomeGreen
                            : Colormanager.expenseRed)
                        .withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                e.isIncome ? Icons.wallet : Icons.shopping_bag,
                color: e.isIncome
                    ? Colormanager.incomeGreen
                    : Colormanager.expenseRed,
              ),
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
                    ),
                  ),
                  Text(
                    e.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (e.isIncome ? "+" : "-") + "\$${e.amount}",
                  style: TextStyle(
                    color: e.isIncome
                        ? Colormanager.incomeGreen
                        : Colormanager.expenseRed,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "10:00 AM",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }