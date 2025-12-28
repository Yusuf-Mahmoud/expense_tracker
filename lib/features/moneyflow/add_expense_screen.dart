import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/moneyflow/widget/continue.dart';
import 'package:expense_tracker/features/moneyflow/widget/customtextfield.dart';
import 'package:expense_tracker/features/moneyflow/widget/repeat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFD3C4A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Expense", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [Spacer(), buildAmountSection(), buildFormContainer()],
      ),
    );
  }

  Widget buildAmountSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How much?",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 18,
            ),
          ),
          TextField(
            controller: amountController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              prefixText: "\$",
              prefixStyle: TextStyle(color: Colors.white, fontSize: 64),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          _buildDropdownField(),
          SizedBox(height: 16),
          CustomTextField(controller: titleController, hint: "Description"),
          SizedBox(height: 16),
          RepeatSwitch(value: false, onChanged: (v) {}),
          SizedBox(height: 24),
          PrimaryButton(
            text: "Continue",
            onPressed: () {
              if (amountController.text.isEmpty || selectedCategory == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter all required fields."),
                  ),
                );
                return;
              }

              final expense = ExpenseModel(
              
                title: titleController.text.isEmpty
                    ? "Expense"
                    : titleController.text,
                category: selectedCategory!,
                amount: double.parse(amountController.text),
                date: DateTime.now(),
                isIncome: false,
              );
              context.read<ExpenseCubit>().addExpense(expense);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: const Text(
            "Select Category",
            style: TextStyle(color: Colors.grey),
          ),
          isExpanded: true,
          items: <String>['Food', 'Transport', 'Shopping', 'Bills'].map((
            String value,
          ) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }
}
