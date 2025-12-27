import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:hive/hive.dart';

class HiveLocalStorage {
  static const String boxName = 'expenses_box';

  Box<ExpenseModel> get box => Hive.box<ExpenseModel>(boxName);

  Future<void> addExpense(ExpenseModel expense) async {
    await box.add(expense);
  }

  List<ExpenseModel> getExpenses() {
    return box.values.toList();
  }

  Future<void> deleteExpense(int index) async {
    await box.deleteAt(index);
  }

  double totalIncome() {
    return box.values
        .where((e) => e.isIncome)
        .fold(0, (sum, e) => sum + e.amount);
  }

  double totalExpense() {
    return box.values
        .where((e) => !e.isIncome)
        .fold(0, (sum, e) => sum + e.amount);
  }
}
