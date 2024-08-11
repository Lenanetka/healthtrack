import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'journal_database.g.dart';

class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get datetime => dateTime()();
  TextColumn get content => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text()(); // 'weight', 'meal', 'bloodsugar'
}

@DriftDatabase(tables: [JournalEntries])
class JournalDatabase extends _$JournalDatabase {
  JournalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'journal_database');
  }
}
