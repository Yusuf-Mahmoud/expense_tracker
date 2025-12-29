// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/features/home/widget/appheader.dart';
import 'package:expense_tracker/features/home/widget/transaction_item.dart';
import 'package:fl_chart/fl_chart.dart';
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
          return Center(child: CircularProgressIndicator());
        }
        final balance = state.income - state.expense;
        return SingleChildScrollView(
          child: Column(
            children: [
              appheader(balance, state.income, state.expense),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 160,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 10,
                        top: 20,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primaryViolet.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _getSpots(state.expenses, isIncome: false),
                              isCurved: true,
                              color: ColorManager.expenseRed,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: ColorManager.expenseRed.withOpacity(0.1),
                              ),
                            ),
                            LineChartBarData(
                              spots: _getSpots(state.expenses, isIncome: true),
                              isCurved: true,
                              color: Colors.green,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: ColorManager.incomeGreen.withOpacity(
                                  0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Transaction",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.expenses.length,
                      itemBuilder: (context, index) {
                        return buildTransactionItem(
                          state.expenses[index],
                          context,
                          index,
                        );
                      },
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<FlSpot> _getSpots(
    List<ExpenseModel> expenses, {
    required bool isIncome,
  }) {
    final filtered = expenses.where((e) => e.isIncome == isIncome).toList();

    filtered.sort((a, b) => a.date.compareTo(b.date));

    List<FlSpot> spots = [];
    for (int i = 0; i < filtered.length; i++) {
      spots.add(FlSpot(i.toDouble(), filtered[i].amount));
    }

    return spots.isEmpty ? [const FlSpot(0, 0)] : spots;
  }
}
