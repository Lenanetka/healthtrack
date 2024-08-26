import 'package:flutter/material.dart';

abstract class Entry {
  Icon get icon;
  String get defaultContent;
  String get title;
  int? get id;
  DateTime get datetime;
  String get content;
  String get displayedContent;
  String get description;
  String get type;

  static const String all = 'all';
  static const String weight = 'weight';
  static const String bloodsugar = 'bloodsugar';
  static const String meal = 'meal';

  static const Map<String, Icon> icons = {
    all: Icon(Icons.filter_list),
    weight: Icon(Icons.monitor_weight),
    bloodsugar: Icon(Icons.opacity),
    meal: Icon(Icons.restaurant_menu),
  };

  static const List<String> options = [all, weight, bloodsugar, meal];
  static const List<String> names = ['All', 'Weight', 'Blood sugar', 'Meal'];

  static Map<String, String> nameByOption = Map.fromIterables(options, names);
  static Map<String, String> optionByName = Map.fromIterables(names, options);

  static Map<String, String> defaultContents = {
    weight: '70',
    bloodsugar: '5',
    meal: Meal.breakfast,
  };

  static const Map<String, String?> units = {
    weight: 'kg',
    bloodsugar: 'mmol/l',
    meal: null,
  };
}

class EntryDB implements Entry {
  @override
  Icon get icon => Entry.icons[type]!;
  @override
  String get defaultContent => Entry.defaultContents[type]!;
  @override
  String get title => Entry.nameByOption[type]!;

  @override
  int? id;
  @override
  final DateTime datetime;
  @override
  final String content;
  @override
  String get displayedContent =>
      Entry.units[type] != null ? '$content ${Entry.units[type]!}' : Meal.nameByOption[content] ?? content;
  @override
  final String description;
  @override
  final String type;

  EntryDB({this.id, required this.datetime, required this.content, required this.description, required this.type});
}

class Weight extends EntryDB {
  static String TYPE = Entry.weight;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.nameByOption[TYPE]!;

  final double amount;

  Weight({
    super.id,
    required super.datetime,
    required this.amount,
    required super.description,
  }) : super(
          content: '$amount',
          type: Entry.weight,
        );
}

class BloodSugar extends EntryDB {
  static String TYPE = Entry.bloodsugar;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.nameByOption[TYPE]!;

  final double amount;
  @override
  String get type => Entry.bloodsugar;

  BloodSugar({
    super.id,
    required super.datetime,
    required this.amount,
    required super.description,
  }) : super(
          content: '$amount',
          type: Entry.bloodsugar,
        );
}

class Meal extends EntryDB {
  static String TYPE = Entry.meal;
  static Icon get ICON => Entry.icons[TYPE]!;
  static String get DEFAULT => Entry.defaultContents[TYPE]!;
  static String get TITLE => Entry.nameByOption[TYPE]!;

  final String option;

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
    required super.datetime,
    required this.option,
    required super.description,
  }) : super(
          content: option,
          type: Entry.meal,
        );
}
