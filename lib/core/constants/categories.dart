import 'package:expense_tracker/core/model/category_model.dart';
import 'package:flutter/material.dart';

final List<ExpenseCategory> expenseCategories = [
  ExpenseCategory(
    name: 'Food',
    icon: Icons.fastfood,
    color: Colors.orange,
  ),
  ExpenseCategory(
    name: 'Shopping',
    icon: Icons.shopping_bag,
    color: Colors.purple,
  ),
  ExpenseCategory(
    name: 'Subscription',
    icon: Icons.subscriptions,
    color: Colors.blue,
  ),
  ExpenseCategory(
    name: 'Transport',
    icon: Icons.directions_car,
    color: Colors.green,
  ),
  ExpenseCategory(
    name: 'Bills',
    icon: Icons.receipt,
    color: Colors.red,
  ),
];
