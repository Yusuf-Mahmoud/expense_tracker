import 'package:expense_tracker/features/home/widget/appheader.dart';
import 'package:expense_tracker/features/home/widget/timecon.dart';
import 'package:expense_tracker/features/home/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';
import 'package:expense_tracker/core/theme/theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is! ExpenseLoaded) {
          return  Center(child: CircularProgressIndicator());
        }
        final balance = state.income - state.expense;
        return SingleChildScrollView(
          child: Column(
            children: [
              appheader(balance, state.income, state.expense),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 20),
                     Text("Spend Frequency", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                     SizedBox(height: 10),
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colormanager.primaryViolet.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: Icon(Icons.show_chart, size: 50, color: Colormanager.primaryViolet)),
                    ),
                     SizedBox(height: 20),
                    buildTimeFilter(), 
                     SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Recent Transaction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: Text("See All", style: TextStyle(color: Colormanager.primaryViolet))),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.expenses.length,
                      itemBuilder: (context, index) {
                        return buildTransactionItem(state.expenses[index], context, index);
                      },
                    ),
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}