import 'package:expense_tracker/core/hive/local.dart';
import 'package:expense_tracker/core/model/expense_model.dart';
import 'package:expense_tracker/features/auth/cubit/logic.dart';
import 'package:expense_tracker/features/home/cubit/logic.dart';
import 'package:expense_tracker/features/splash/splash_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('expenses_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit()),
      
      BlocProvider(
      create: (_) => ExpenseCubit(HiveLocalStorage()),
    ),],
      child: MaterialApp(
        title: 'Expense Tracker',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        
      ),
    );
  }
}
