import 'package:flutter/material.dart';

abstract class JournalEntry {
  Icon get icon;
  String get unit;
  double get amount;
  DateTime get dateTime;
}

class WeightEntry implements JournalEntry {
  @override
  Icon get icon => const Icon(Icons.fitness_center);
  @override
  String get unit => 'kg';
  @override
  final double amount;
  @override
  final DateTime dateTime;

  WeightEntry({required this.dateTime, required this.amount});
}

class BloodSugarEntry implements JournalEntry {
  @override
  Icon get icon => const Icon(Icons.local_hospital);
  @override
  String get unit => 'mmol/l';
  @override
  final double amount;
  @override
  final DateTime dateTime;

  BloodSugarEntry({required this.dateTime, required this.amount});
}
