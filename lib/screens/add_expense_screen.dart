/**
 * Course: MAD201-01 Cross Platform MA
 * Assignment 2
 * Student Name: Manpreet Singh
 * Student ID: A00198842
 * Description: Allows user to input and save a new expense.
 */

import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;

  /// Opens a date picker dialog
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  /// Validates input and sends new expense to HomeScreen
  void _saveExpense() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Amount must be greater than 0")),
      );
      return;
    }

    final newExpense = Expense(
      title: _titleController.text,
      amount: amount,
      description: _descController.text,
      date: _selectedDate!,
    );

    // Clear inputs after saving
    _titleController.clear();
    _amountController.clear();
    _descController.clear();

    Navigator.pop(context, newExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title input
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Expense Title"),
            ),
            // Amount input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            // Description input
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 10),
            // Date Picker Row
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? "No Date Chosen"
                      : "Picked: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text("Choose Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveExpense,
              child: const Text("Save Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
