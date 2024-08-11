import 'package:flutter/material.dart';

abstract class Journal {
  Icon get icon;
  int? get id;
  DateTime get dateTime;
  String get content;
  String get displayedContent;
  String get description;
  String get type;
}

class Weight implements Journal {
  @override
  Icon get icon => const Icon(Icons.fitness_center);
  @override
  final int? id;
  @override
  final DateTime dateTime;
  final double amount;
  String get unit => 'kg';
  @override
  String get content => '$amount';
  @override
  String get displayedContent => '$amount $unit';
  @override
  final String description;
  @override
  String get type => 'weight';

  Weight({required this.id, required this.dateTime, required this.amount, required this.description});
}

class BloodSugar implements Journal {
  @override
  Icon get icon => const Icon(Icons.local_hospital);
  @override
  final int? id;
  @override
  final DateTime dateTime;
  final double amount;
  String get unit => 'mmol/l';
  @override
  String get content => '$amount';
  @override
  String get displayedContent => '$amount $unit';
  @override
  final String description;
  @override
  String get type => 'bloodsugar';

  BloodSugar({required this.id, required this.dateTime, required this.amount, required this.description});
}

class Meal implements Journal {
  @override
  Icon get icon => const Icon(Icons.restaurant);
  @override
  final int? id;
  @override
  final DateTime dateTime;
  final String name;
  @override
  String get content => name;
  @override
  String get displayedContent => name;
  @override
  final String description;
  @override
  String get type => 'meal';

  Meal({required this.id, required this.dateTime, required this.name, required this.description});
}
