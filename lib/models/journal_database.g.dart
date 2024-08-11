// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_database.dart';

// ignore_for_file: type=lint
class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, datetime, content, description, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(Insertable<JournalEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('datetime')) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta));
    } else if (isInserting) {
      context.missing(_datetimeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final DateTime datetime;
  final String content;
  final String? description;
  final String type;
  const JournalEntry(
      {required this.id,
      required this.datetime,
      required this.content,
      this.description,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['datetime'] = Variable<DateTime>(datetime);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      datetime: Value(datetime),
      content: Value(content),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
    );
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
      content: serializer.fromJson<String>(json['content']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'datetime': serializer.toJson<DateTime>(datetime),
      'content': serializer.toJson<String>(content),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
    };
  }

  JournalEntry copyWith(
          {int? id,
          DateTime? datetime,
          String? content,
          Value<String?> description = const Value.absent(),
          String? type}) =>
      JournalEntry(
        id: id ?? this.id,
        datetime: datetime ?? this.datetime,
        content: content ?? this.content,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
      );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
      content: data.content.present ? data.content.value : this.content,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('datetime: $datetime, ')
          ..write('content: $content, ')
          ..write('description: $description, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, datetime, content, description, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.datetime == this.datetime &&
          other.content == this.content &&
          other.description == this.description &&
          other.type == this.type);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<DateTime> datetime;
  final Value<String> content;
  final Value<String?> description;
  final Value<String> type;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.datetime = const Value.absent(),
    this.content = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime datetime,
    required String content,
    this.description = const Value.absent(),
    required String type,
  })  : datetime = Value(datetime),
        content = Value(content),
        type = Value(type);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? datetime,
    Expression<String>? content,
    Expression<String>? description,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (datetime != null) 'datetime': datetime,
      if (content != null) 'content': content,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
    });
  }

  JournalEntriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? datetime,
      Value<String>? content,
      Value<String?>? description,
      Value<String>? type}) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      datetime: datetime ?? this.datetime,
      content: content ?? this.content,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('datetime: $datetime, ')
          ..write('content: $content, ')
          ..write('description: $description, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$JournalDatabase extends GeneratedDatabase {
  _$JournalDatabase(QueryExecutor e) : super(e);
  $JournalDatabaseManager get managers => $JournalDatabaseManager(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [journalEntries];
}

typedef $$JournalEntriesTableCreateCompanionBuilder = JournalEntriesCompanion
    Function({
  Value<int> id,
  required DateTime datetime,
  required String content,
  Value<String?> description,
  required String type,
});
typedef $$JournalEntriesTableUpdateCompanionBuilder = JournalEntriesCompanion
    Function({
  Value<int> id,
  Value<DateTime> datetime,
  Value<String> content,
  Value<String?> description,
  Value<String> type,
});

class $$JournalEntriesTableTableManager extends RootTableManager<
    _$JournalDatabase,
    $JournalEntriesTable,
    JournalEntry,
    $$JournalEntriesTableFilterComposer,
    $$JournalEntriesTableOrderingComposer,
    $$JournalEntriesTableCreateCompanionBuilder,
    $$JournalEntriesTableUpdateCompanionBuilder> {
  $$JournalEntriesTableTableManager(
      _$JournalDatabase db, $JournalEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$JournalEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$JournalEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> type = const Value.absent(),
          }) =>
              JournalEntriesCompanion(
            id: id,
            datetime: datetime,
            content: content,
            description: description,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime datetime,
            required String content,
            Value<String?> description = const Value.absent(),
            required String type,
          }) =>
              JournalEntriesCompanion.insert(
            id: id,
            datetime: datetime,
            content: content,
            description: description,
            type: type,
          ),
        ));
}

class $$JournalEntriesTableFilterComposer
    extends FilterComposer<_$JournalDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$JournalEntriesTableOrderingComposer
    extends OrderingComposer<_$JournalDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $JournalDatabaseManager {
  final _$JournalDatabase _db;
  $JournalDatabaseManager(this._db);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
}
