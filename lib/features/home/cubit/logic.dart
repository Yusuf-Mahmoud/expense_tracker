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

  //fliter by category
  // void flitercategory(String category) {
  
  //   final allExpenses = storage.getExpenses();
  //   final filteredExpenses = allExpenses
  //       .where((expense) => expense.category == category)
  //       .toList();
  //   emit(ExpenseFiltered(filteredExpenses));
    
    
  // }
  void filterExpenses({String? category, int? monthsLimit}) {
  final allExpenses = storage.getExpenses();
  DateTime now = DateTime.now();

  List<ExpenseModel> filtered = allExpenses.where((expense) {
    bool matchesCategory = true;
    bool matchesDate = true;

    if (category != null && category != "All") {
      matchesCategory = (expense.category == category);
    }

    if (monthsLimit != null) {
      DateTime startDate = DateTime(now.year, now.month - monthsLimit, now.day);
      matchesDate = expense.date.isAfter(startDate);
    }

    return matchesCategory && matchesDate;
  }).toList();

  filtered.sort((a, b) => b.date.compareTo(a.date));

  emit(ExpenseLoaded(
    filtered, 
    storage.totalIncome(), 
    storage.totalExpense()
  ));
}
}