import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/core/model/expense_model.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    bool isIncome = false;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            SwitchListTile(
              title: const Text('Is Income'),
              value: isIncome,
              onChanged: (v) {
                isIncome = v;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final expense = ExpenseModel(
                  title: titleController.text,
                  category: 'General',
                  amount: double.parse(amountController.text),
                  date: DateTime.now(),
                  isIncome: isIncome, id: '',
                );

                context.read<ExpenseCubit>().addExpense(expense);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
