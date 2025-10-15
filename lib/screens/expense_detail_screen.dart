/**
 * Course: MAD201-01 Cross Platform MA
 * Assignment 2
 * Student Name: Manpreet Singh
 * Student ID: A00198842
 * Description: Displays detailed information of a selected expense.
 */

import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${expense.title}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Amount: \$${expense.amount.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            Text("Date: ${expense.date.toLocal().toString().split(' ')[0]}"),
            const SizedBox(height: 8),
            Text("Description: ${expense.description}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
