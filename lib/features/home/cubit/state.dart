import 'package:expense_tracker/core/model/expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseModel> expenses;
  final double income;
  final double expense;

  ExpenseLoaded(this.expenses, this.income, this.expense);
}