import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/hive/local.dart';
import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/features/home/cubit/state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final HiveLocalStorage storage;

  ExpenseCubit(this.storage) : super(ExpenseInitial()) {
    loadExpenses();
  }

  void loadExpenses() {
    emit(
      ExpenseLoaded(
        storage.getExpenses(),
        storage.totalIncome(),
        storage.totalExpense(),
      ),
    );
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await storage.addExpense(expense);
    loadExpenses();
  }

  Future<void> deleteExpense(int index) async {
    await storage.deleteExpense(index);
    loadExpenses();
  }
}