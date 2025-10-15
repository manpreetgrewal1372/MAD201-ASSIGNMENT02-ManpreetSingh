/**
 * Course: MAD201-01 Cross Platform MA
 * Assignment 2: Personal Expense Tracker
 * Student Name: Manpreet Singh
 * Student ID: A00198842
 * Description: Defines the Expense model with required fields.
 */

class Expense {
  final String title;
  final double amount;
  final String description;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
  });
}
