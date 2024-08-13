import 'package:flutter/material.dart';

abstract class Entry {
  Icon get icon;
  String get defaultContent;
  String get title;
  int? get id;
  DateTime get dateTime;
  String get content;
  String get displayedContent;
  String get description;
  String get type;

  static const String weight = 'weight';
  static const String bloodsugar = 'bloodsugar';
  static const String meal = 'meal';

  static const Map<String, Icon> icons = {
    weight: Icon(Icons.fitness_center),
    bloodsugar: Icon(Icons.local_hospital),
    meal: Icon(Icons.restaurant),
  };

  static const Map<String, String> titles = {
    weight: 'Weight',
    bloodsugar: 'Blood sugar',
    meal: 'Meal',
  };

  static Map<String, String> defaultContents = {
    weight: '70',
    bloodsugar: '5',
    meal: Meal.nameByOption[Meal.breakfast]!,
  };

  static const Map<String, String?> units = {
    weight: 'kg',
    bloodsugar: 'mmol/l',
    meal: null,
  };
}

class EntryToSave implements Entry {
  @override
  Icon get icon => Entry.icons[type]!;
  @override
  String get defaultContent => Entry.defaultContents[type]!;
  @override
  String get title => Entry.titles[type]!;

  @override
  final int? id;
  @override
  final DateTime dateTime;
  @override
  final String content;
  @override
  String get displayedContent =>
      Entry.units[type] != null ? '$content ${Entry.units[type]!}' : content;
  @override
  final String description;
  @override
  final String type;

  EntryToSave(
      {this.id,
      required this.dateTime,
      required this.content,
      required this.description,
      required this.type});
}

class Weight extends EntryToSave {
  static String TYPE = Entry.weight;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.titles[TYPE]!;
  
  final double amount;

  Weight({
    super.id,
    required super.dateTime,
    required this.amount,
    required super.description,
  }) : super(
          content: '$amount',
          type: Entry.weight,
        );
}

class BloodSugar extends EntryToSave {
  static String TYPE = Entry.bloodsugar;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.titles[TYPE]!;

  final double amount;
  @override
  String get type => Entry.bloodsugar;

  BloodSugar({
    super.id,
    required super.dateTime,
    required this.amount,
    required super.description,
  }) : super(
          content: '$amount',
          type: Entry.bloodsugar,
        );
}

class Meal extends EntryToSave {
  static String TYPE = Entry.meal;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.titles[TYPE]!;

  final String option;

  @override
  String get displayedContent => nameByOption[option]!;

  static const String breakfast = 'breakfast';
  static const String lunch = 'lunch';
  static const String dinner = 'dinner';
  static const String snack = 'snack';

  static const List<String> options = [breakfast, lunch, dinner, snack];
  static const List<String> names = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  static Map<String, String> nameByOption = Map.fromIterables(options, names);
  static Map<String, String> optionByName = Map.fromIterables(names, options);

  Meal({
    super.id,
    required super.dateTime,
    required this.option,
    required super.description,
  }) : super(
          content: option,
          type: Entry.meal,
        );
}
