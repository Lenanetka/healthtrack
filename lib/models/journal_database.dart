import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'journal_models.dart';

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
  JournalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveJournalEntry(Journal journal) async {
    final entry = JournalEntriesCompanion(
      datetime: Value(journal.dateTime),
      content: Value(journal.content),
      description: Value(journal.description),
      type: Value(journal.type),
    );
    if (journal.id == null) {
      await into(journalEntries).insert(entry);
    } else {
      await (update(journalEntries)..where((tbl) => tbl.id.equals(journal.id!)))
          .write(entry);
    }
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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'journal_database.sqlite'));
    return NativeDatabase(file);
  });
}
