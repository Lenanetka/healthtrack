import 'package:flutter/material.dart';

abstract class JournalEntry {
  Icon get icon;
  DateTime get dateTime;
  String get content;
  String get description;
}

class Weight implements JournalEntry {
  @override
  Icon get icon => const Icon(Icons.fitness_center);
  @override
  final DateTime dateTime;
  final double amount;
  String get unit => 'kg';
  @override
  String get content => '$amount $unit';
  @override
  final String description;

  Weight({required this.dateTime, required this.amount, required this.description});
}

class BloodSugar implements JournalEntry {
  @override
  Icon get icon => const Icon(Icons.local_hospital);
  @override
  final DateTime dateTime;
  final double amount;
  String get unit => 'mmol/l';
  @override
  String get content => '$amount $unit';
  @override
  final String description;

  BloodSugar({required this.dateTime, required this.amount, required this.description});
}

class Meal implements JournalEntry {
  @override
  Icon get icon => const Icon(Icons.restaurant);
  @override
  final DateTime dateTime;
  @override
  final String type;
  @override
  String get content => type;
  @override
  final String description;

  Meal({required this.dateTime, required this.type, required this.description});
}
