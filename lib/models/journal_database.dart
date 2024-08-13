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
  TextColumn get type => text()();
}

@DriftDatabase(tables: [JournalEntries])
class JournalDatabase extends _$JournalDatabase {
  JournalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveJournalEntry(EntryToSave entry) async {
    final entryToSave = JournalEntriesCompanion(
      datetime: Value(entry.dateTime),
      content: Value(entry.content),
      description: Value(entry.description),
      type: Value(entry.type),
    );
    if (entry.id == null) {
      await into(journalEntries).insert(entryToSave);
    } else {
      await (update(journalEntries)..where((tbl) => tbl.id.equals(entry.id!)))
          .write(entryToSave);
    }
  }

  Future<void> deleteJournalEntry(int id) async {
    await (delete(journalEntries)..where((entry) => entry.id.equals(id))).go();
  }

  Future<List<Entry>> getJournalByDate(DateTime from, DateTime to) async {
    final entries = await (select(journalEntries)
          ..where((entry) => entry.datetime.isBetweenValues(from, to))
          ..orderBy([(entry) => OrderingTerm.desc(entry.datetime)]))
        .get();

    return entries.map((entry) {
      return EntryToSave(
        id: entry.id,
        dateTime: entry.datetime,
        content: entry.content,
        description: entry.description ?? '',
        type: entry.type,
      );
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
