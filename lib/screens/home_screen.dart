/**
 * Course: MAD201-01 Cross Platform MA
 * Assignment 2
 * Student Name: Manpreet Singh
 * Student ID: A00198842
 * Description: Displays list of expenses, navigates to add/view details, and allows deletion of expenses.
 */

import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Stores list of all expenses in memory
  List<Expense> _expenses = [];

  /// Calculates total expense
  double get totalExpense {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }

  /// Opens AddExpenseScreen and adds new expense
  void _navigateToAddExpense() async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );

    if (newExpense != null && newExpense is Expense) {
      setState(() {
        _expenses.add(newExpense);
      });
    }
  }

  /// Opens expense detail screen
  void _viewExpenseDetail(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense),
      ),
    );
  }

  /// Deletes an expense from the list
  void _deleteExpense(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this expense?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _expenses.removeAt(index);
              });
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expense Tracker"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.account_balance_wallet),
          ),
        ],
      ),
      body: Column(
        children: [
          // Total Expense Summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade100,
            width: double.infinity,
            child: Text(
              "Total Expense: \$${totalExpense.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Expense List
          Expanded(
            child: _expenses.isEmpty
                ? const Center(child: Text("No expenses added yet."))
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final exp = _expenses[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: Text(exp.title),
                          subtitle: Text(
                              "${exp.date.toLocal().toString().split(' ')[0]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${exp.amount.toStringAsFixed(2)}"),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => _deleteExpense(index),
                                child: const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          onTap: () => _viewExpenseDetail(exp),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
