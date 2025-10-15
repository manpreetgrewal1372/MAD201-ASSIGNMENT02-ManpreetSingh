/**
 * Course: MAD201-01 Cross Platform MA
 * Assignment 2
 * Student Name: Manpreet Singh
 * Student ID: A00198842
 * Description: Entry point of the Personal Expense Tracker app.
 */

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
