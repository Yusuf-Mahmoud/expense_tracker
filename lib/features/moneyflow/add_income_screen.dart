import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/moneyflow/widget/continue.dart';
import 'package:expense_tracker/features/moneyflow/widget/customtextfield.dart';
import 'package:expense_tracker/features/moneyflow/widget/repeat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});
  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A86B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Income", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Spacer(),
          _buildAmountSection(),
          _buildFormContainer(),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
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

  Widget _buildFormContainer() {
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
          CustomTextField(controller: titleController, hint: "Description"),
          const SizedBox(height: 16),
          RepeatSwitch(value: false, onChanged: (v) {}),
          const SizedBox(height: 24),
          PrimaryButton(
            text: "Continue",
            onPressed: () {
              if (amountController.text.isEmpty) return;

              final income = ExpenseModel(
                title: titleController.text.isEmpty
                    ? "Income"
                    : titleController.text,
                category: "Income",
                amount: double.parse(amountController.text),
                date: DateTime.now(),
                isIncome: true,
              );

              context.read<ExpenseCubit>().addExpense(income);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
