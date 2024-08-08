import 'package:flutter/material.dart';

abstract class JournalEntry {
  Icon get icon;
  DateTime get dateTime;
  String get content;
  String get description;
}

class Weight implements JournalEntry {
  static const String name = 'Weight';
  static const Icon staticIcon = Icon(Icons.fitness_center);
  @override
  Icon get icon => staticIcon;
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
  static const String name = 'Blood sugar';
  static const Icon staticIcon = Icon(Icons.local_hospital);
  @override
  Icon get icon => staticIcon;
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
  static const String name = 'Meal';
  static const Icon staticIcon = Icon(Icons.restaurant);
  @override
  Icon get icon => staticIcon;
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
