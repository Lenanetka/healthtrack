import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'journal.dart';

part 'journal_database.g.dart';

@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get datetime => dateTime()();
  TextColumn get content => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text()(); // 'weight', 'meal', 'bloodsugar'
}

@DriftDatabase(tables: [JournalEntries])
class JournalDatabase extends _$JournalDatabase {
  static final JournalDatabase _instance = JournalDatabase._internal();
  factory JournalDatabase() {
    return _instance;
  }
  JournalDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'journal_database.db');
  }

  Future<void> saveJournalEntry(Journal journal) async {
    final entry = JournalEntriesCompanion(
      datetime: Value(journal.dateTime),
      content: Value(journal.content),
      description: Value(journal.description),
      type: Value(journal.type),
    );
    await into(journalEntries).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteJournalEntry(int id) async {
    await (delete(journalEntries)..where((entry) => entry.id.equals(id))).go();
  }

  Future<List<Journal>> getJournalByDate(DateTime from, DateTime to) async {
    final entries = await (select(journalEntries)
          ..where((entry) => entry.datetime.isBetweenValues(from, to))
          ..orderBy([(entry) => OrderingTerm.desc(entry.datetime)]))
        .get();

    return entries.map((entry) {
      switch (entry.type) {
        case 'weight':
          return Weight(
            id: entry.id,
            dateTime: entry.datetime,
            amount: double.parse(entry.content),
            description: entry.description ?? '',
          );
        case 'bloodsugar':
          return BloodSugar(
            id: entry.id,
            dateTime: entry.datetime,
            amount: double.parse(entry.content),
            description: entry.description ?? '',
          );
        case 'meal':
          return Meal(
            id: entry.id,
            dateTime: entry.datetime,
            name: entry.content,
            description: entry.description ?? '',
          );
        default:
          throw Exception('Unknown journal entry type: ${entry.type}');
      }
    }).toList();
  }
}
