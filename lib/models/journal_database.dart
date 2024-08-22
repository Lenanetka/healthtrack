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

  Future<void> addJournalEntry(EntryDB entry) async {
    final entryDB = JournalEntriesCompanion(
      datetime: Value(entry.datetime),
      content: Value(entry.content),
      description: Value(entry.description),
      type: Value(entry.type),
    );
    await into(journalEntries).insert(entryDB);
  }

  Future<void> editJournalEntry(EntryDB entry) async {
    final entryDB = JournalEntriesCompanion(
      datetime: Value(entry.datetime),
      content: Value(entry.content),
      description: Value(entry.description),
      type: Value(entry.type),
    );
    await (update(journalEntries)..where((tbl) => tbl.id.equals(entry.id!)))
        .write(entryDB);
  }

  Future<void> deleteJournalEntry(int id) async {
    await (delete(journalEntries)..where((entry) => entry.id.equals(id))).go();
  }

  Future<List<Entry>> getJournalByDate(DateTime from) async {
    const size = 50;

    final entries = await (select(journalEntries)
          ..where((entry) => entry.datetime.isSmallerThanValue(from))
          ..orderBy([(entry) => OrderingTerm.desc(entry.datetime)])
          ..limit(size))
        .get();

    return entries.map((entry) {
      return EntryDB(
        id: entry.id,
        datetime: entry.datetime,
        content: entry.content,
        description: entry.description ?? '',
        type: entry.type,
      );
    }).toList();
  }

  Future<List<Entry>> getJournalByDateMocked(DateTime from) async {
    const size = 15;

    List<EntryDB> entries = [];
    for (int i = 0; i < size; i++) {
      switch (i % 3) {
        case 0:
          entries.add(EntryDB(
            id: i,
            datetime: from.subtract(Duration(days: i)),
            content: (60 + i / 10).toString(),
            description: "Index $i",
            type: "weight",
          ));
          break;
        case 1:
          entries.add(EntryDB(
            id: i,
            datetime: from.subtract(Duration(days: i)),
            content: (5 + i / 100).toString(),
            description: "Index $i",
            type: "bloodsugar",
          ));
          break;
        case 2:
          entries.add(EntryDB(
            id: i,
            datetime: from.subtract(Duration(days: i)),
            content: "Snack",
            description: "Index $i",
            type: "meal",
          ));
          break;
      }
    }

    return entries;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'journal_database.sqlite'));
    return NativeDatabase(file);
  });
}
