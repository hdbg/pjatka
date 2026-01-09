// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UniversityClassTable extends UniversityClass
    with TableInfo<$UniversityClassTable, UniversityClassData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UniversityClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ClassKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ClassKind>($UniversityClassTable.$converterkind);
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastCheckedMeta = const VerificationMeta(
    'lastChecked',
  );
  @override
  late final GeneratedColumn<DateTime> lastChecked = GeneratedColumn<DateTime>(
    'last_checked',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
    'room',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    code,
    kind,
    startTime,
    endTime,
    lastChecked,
    room,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'university_class';
  @override
  VerificationContext validateIntegrity(
    Insertable<UniversityClassData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('last_checked')) {
      context.handle(
        _lastCheckedMeta,
        lastChecked.isAcceptableOrUnknown(
          data['last_checked']!,
          _lastCheckedMeta,
        ),
      );
    }
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UniversityClassData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UniversityClassData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      kind: $UniversityClassTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      lastChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_checked'],
      )!,
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      ),
    );
  }

  @override
  $UniversityClassTable createAlias(String alias) {
    return $UniversityClassTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ClassKind, String, String> $converterkind =
      const EnumNameConverter<ClassKind>(ClassKind.values);
}

class UniversityClassData extends DataClass
    implements Insertable<UniversityClassData> {
  final String id;
  final String name;
  final String code;
  final ClassKind kind;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime lastChecked;
  final String? room;
  const UniversityClassData({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    required this.startTime,
    required this.endTime,
    required this.lastChecked,
    this.room,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    {
      map['kind'] = Variable<String>(
        $UniversityClassTable.$converterkind.toSql(kind),
      );
    }
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['last_checked'] = Variable<DateTime>(lastChecked);
    if (!nullToAbsent || room != null) {
      map['room'] = Variable<String>(room);
    }
    return map;
  }

  UniversityClassCompanion toCompanion(bool nullToAbsent) {
    return UniversityClassCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      kind: Value(kind),
      startTime: Value(startTime),
      endTime: Value(endTime),
      lastChecked: Value(lastChecked),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
    );
  }

  factory UniversityClassData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UniversityClassData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      kind: $UniversityClassTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      lastChecked: serializer.fromJson<DateTime>(json['lastChecked']),
      room: serializer.fromJson<String?>(json['room']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'kind': serializer.toJson<String>(
        $UniversityClassTable.$converterkind.toJson(kind),
      ),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'lastChecked': serializer.toJson<DateTime>(lastChecked),
      'room': serializer.toJson<String?>(room),
    };
  }

  UniversityClassData copyWith({
    String? id,
    String? name,
    String? code,
    ClassKind? kind,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? lastChecked,
    Value<String?> room = const Value.absent(),
  }) => UniversityClassData(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    kind: kind ?? this.kind,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    lastChecked: lastChecked ?? this.lastChecked,
    room: room.present ? room.value : this.room,
  );
  UniversityClassData copyWithCompanion(UniversityClassCompanion data) {
    return UniversityClassData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      kind: data.kind.present ? data.kind.value : this.kind,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      lastChecked: data.lastChecked.present
          ? data.lastChecked.value
          : this.lastChecked,
      room: data.room.present ? data.room.value : this.room,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UniversityClassData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('kind: $kind, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lastChecked: $lastChecked, ')
          ..write('room: $room')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, code, kind, startTime, endTime, lastChecked, room);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UniversityClassData &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.kind == this.kind &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.lastChecked == this.lastChecked &&
          other.room == this.room);
}

class UniversityClassCompanion extends UpdateCompanion<UniversityClassData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<ClassKind> kind;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<DateTime> lastChecked;
  final Value<String?> room;
  final Value<int> rowid;
  const UniversityClassCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.kind = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.lastChecked = const Value.absent(),
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UniversityClassCompanion.insert({
    required String id,
    required String name,
    required String code,
    required ClassKind kind,
    required DateTime startTime,
    required DateTime endTime,
    this.lastChecked = const Value.absent(),
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       code = Value(code),
       kind = Value(kind),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<UniversityClassData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? kind,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<DateTime>? lastChecked,
    Expression<String>? room,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (kind != null) 'kind': kind,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (lastChecked != null) 'last_checked': lastChecked,
      if (room != null) 'room': room,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UniversityClassCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? code,
    Value<ClassKind>? kind,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<DateTime>? lastChecked,
    Value<String?>? room,
    Value<int>? rowid,
  }) {
    return UniversityClassCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      kind: kind ?? this.kind,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lastChecked: lastChecked ?? this.lastChecked,
      room: room ?? this.room,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $UniversityClassTable.$converterkind.toSql(kind.value),
      );
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (lastChecked.present) {
      map['last_checked'] = Variable<DateTime>(lastChecked.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UniversityClassCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('kind: $kind, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lastChecked: $lastChecked, ')
          ..write('room: $room, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeacherTable extends Teacher with TableInfo<$TeacherTable, TeacherData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeacherTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 512,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES university_class (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, classId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teacher';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeacherData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeacherData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeacherData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
    );
  }

  @override
  $TeacherTable createAlias(String alias) {
    return $TeacherTable(attachedDatabase, alias);
  }
}

class TeacherData extends DataClass implements Insertable<TeacherData> {
  final int id;
  final String name;
  final String classId;
  const TeacherData({
    required this.id,
    required this.name,
    required this.classId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['class_id'] = Variable<String>(classId);
    return map;
  }

  TeacherCompanion toCompanion(bool nullToAbsent) {
    return TeacherCompanion(
      id: Value(id),
      name: Value(name),
      classId: Value(classId),
    );
  }

  factory TeacherData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      classId: serializer.fromJson<String>(json['classId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'classId': serializer.toJson<String>(classId),
    };
  }

  TeacherData copyWith({int? id, String? name, String? classId}) => TeacherData(
    id: id ?? this.id,
    name: name ?? this.name,
    classId: classId ?? this.classId,
  );
  TeacherData copyWithCompanion(TeacherCompanion data) {
    return TeacherData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      classId: data.classId.present ? data.classId.value : this.classId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('classId: $classId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, classId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherData &&
          other.id == this.id &&
          other.name == this.name &&
          other.classId == this.classId);
}

class TeacherCompanion extends UpdateCompanion<TeacherData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> classId;
  const TeacherCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.classId = const Value.absent(),
  });
  TeacherCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String classId,
  }) : name = Value(name),
       classId = Value(classId);
  static Insertable<TeacherData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? classId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (classId != null) 'class_id': classId,
    });
  }

  TeacherCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? classId,
  }) {
    return TeacherCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      classId: classId ?? this.classId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('classId: $classId')
          ..write(')'))
        .toString();
  }
}

class $GroupTable extends Group with TableInfo<$GroupTable, GroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES university_class (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, classId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String name;
  final String classId;
  const GroupData({
    required this.id,
    required this.name,
    required this.classId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['class_id'] = Variable<String>(classId);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      name: Value(name),
      classId: Value(classId),
    );
  }

  factory GroupData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      classId: serializer.fromJson<String>(json['classId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'classId': serializer.toJson<String>(classId),
    };
  }

  GroupData copyWith({int? id, String? name, String? classId}) => GroupData(
    id: id ?? this.id,
    name: name ?? this.name,
    classId: classId ?? this.classId,
  );
  GroupData copyWithCompanion(GroupCompanion data) {
    return GroupData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      classId: data.classId.present ? data.classId.value : this.classId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('classId: $classId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, classId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.name == this.name &&
          other.classId == this.classId);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> classId;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.classId = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String classId,
  }) : name = Value(name),
       classId = Value(classId);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? classId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (classId != null) 'class_id': classId,
    });
  }

  GroupCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? classId,
  }) {
    return GroupCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      classId: classId ?? this.classId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('classId: $classId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UniversityClassTable universityClass = $UniversityClassTable(
    this,
  );
  late final $TeacherTable teacher = $TeacherTable(this);
  late final $GroupTable group = $GroupTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    universityClass,
    teacher,
    group,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'university_class',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('teacher', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'university_class',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UniversityClassTableCreateCompanionBuilder =
    UniversityClassCompanion Function({
      required String id,
      required String name,
      required String code,
      required ClassKind kind,
      required DateTime startTime,
      required DateTime endTime,
      Value<DateTime> lastChecked,
      Value<String?> room,
      Value<int> rowid,
    });
typedef $$UniversityClassTableUpdateCompanionBuilder =
    UniversityClassCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<ClassKind> kind,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<DateTime> lastChecked,
      Value<String?> room,
      Value<int> rowid,
    });

final class $$UniversityClassTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UniversityClassTable,
          UniversityClassData
        > {
  $$UniversityClassTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TeacherTable, List<TeacherData>>
  _teacherRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teacher,
    aliasName: $_aliasNameGenerator(db.universityClass.id, db.teacher.classId),
  );

  $$TeacherTableProcessedTableManager get teacherRefs {
    final manager = $$TeacherTableTableManager(
      $_db,
      $_db.teacher,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_teacherRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupTable, List<GroupData>> _groupRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.group,
    aliasName: $_aliasNameGenerator(db.universityClass.id, db.group.classId),
  );

  $$GroupTableProcessedTableManager get groupRefs {
    final manager = $$GroupTableTableManager(
      $_db,
      $_db.group,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UniversityClassTableFilterComposer
    extends Composer<_$AppDatabase, $UniversityClassTable> {
  $$UniversityClassTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ClassKind, ClassKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastChecked => $composableBuilder(
    column: $table.lastChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> teacherRefs(
    Expression<bool> Function($$TeacherTableFilterComposer f) f,
  ) {
    final $$TeacherTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teacher,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeacherTableFilterComposer(
            $db: $db,
            $table: $db.teacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupRefs(
    Expression<bool> Function($$GroupTableFilterComposer f) f,
  ) {
    final $$GroupTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.group,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableFilterComposer(
            $db: $db,
            $table: $db.group,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UniversityClassTableOrderingComposer
    extends Composer<_$AppDatabase, $UniversityClassTable> {
  $$UniversityClassTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastChecked => $composableBuilder(
    column: $table.lastChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UniversityClassTableAnnotationComposer
    extends Composer<_$AppDatabase, $UniversityClassTable> {
  $$UniversityClassTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ClassKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get lastChecked => $composableBuilder(
    column: $table.lastChecked,
    builder: (column) => column,
  );

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

  Expression<T> teacherRefs<T extends Object>(
    Expression<T> Function($$TeacherTableAnnotationComposer a) f,
  ) {
    final $$TeacherTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teacher,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeacherTableAnnotationComposer(
            $db: $db,
            $table: $db.teacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupRefs<T extends Object>(
    Expression<T> Function($$GroupTableAnnotationComposer a) f,
  ) {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.group,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableAnnotationComposer(
            $db: $db,
            $table: $db.group,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UniversityClassTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UniversityClassTable,
          UniversityClassData,
          $$UniversityClassTableFilterComposer,
          $$UniversityClassTableOrderingComposer,
          $$UniversityClassTableAnnotationComposer,
          $$UniversityClassTableCreateCompanionBuilder,
          $$UniversityClassTableUpdateCompanionBuilder,
          (UniversityClassData, $$UniversityClassTableReferences),
          UniversityClassData,
          PrefetchHooks Function({bool teacherRefs, bool groupRefs})
        > {
  $$UniversityClassTableTableManager(
    _$AppDatabase db,
    $UniversityClassTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UniversityClassTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UniversityClassTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UniversityClassTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<ClassKind> kind = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<DateTime> lastChecked = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversityClassCompanion(
                id: id,
                name: name,
                code: code,
                kind: kind,
                startTime: startTime,
                endTime: endTime,
                lastChecked: lastChecked,
                room: room,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String code,
                required ClassKind kind,
                required DateTime startTime,
                required DateTime endTime,
                Value<DateTime> lastChecked = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversityClassCompanion.insert(
                id: id,
                name: name,
                code: code,
                kind: kind,
                startTime: startTime,
                endTime: endTime,
                lastChecked: lastChecked,
                room: room,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UniversityClassTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({teacherRefs = false, groupRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (teacherRefs) db.teacher,
                if (groupRefs) db.group,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (teacherRefs)
                    await $_getPrefetchedData<
                      UniversityClassData,
                      $UniversityClassTable,
                      TeacherData
                    >(
                      currentTable: table,
                      referencedTable: $$UniversityClassTableReferences
                          ._teacherRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UniversityClassTableReferences(
                            db,
                            table,
                            p0,
                          ).teacherRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.classId == item.id),
                      typedResults: items,
                    ),
                  if (groupRefs)
                    await $_getPrefetchedData<
                      UniversityClassData,
                      $UniversityClassTable,
                      GroupData
                    >(
                      currentTable: table,
                      referencedTable: $$UniversityClassTableReferences
                          ._groupRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UniversityClassTableReferences(
                            db,
                            table,
                            p0,
                          ).groupRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.classId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UniversityClassTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UniversityClassTable,
      UniversityClassData,
      $$UniversityClassTableFilterComposer,
      $$UniversityClassTableOrderingComposer,
      $$UniversityClassTableAnnotationComposer,
      $$UniversityClassTableCreateCompanionBuilder,
      $$UniversityClassTableUpdateCompanionBuilder,
      (UniversityClassData, $$UniversityClassTableReferences),
      UniversityClassData,
      PrefetchHooks Function({bool teacherRefs, bool groupRefs})
    >;
typedef $$TeacherTableCreateCompanionBuilder =
    TeacherCompanion Function({
      Value<int> id,
      required String name,
      required String classId,
    });
typedef $$TeacherTableUpdateCompanionBuilder =
    TeacherCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> classId,
    });

final class $$TeacherTableReferences
    extends BaseReferences<_$AppDatabase, $TeacherTable, TeacherData> {
  $$TeacherTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UniversityClassTable _classIdTable(_$AppDatabase db) =>
      db.universityClass.createAlias(
        $_aliasNameGenerator(db.teacher.classId, db.universityClass.id),
      );

  $$UniversityClassTableProcessedTableManager get classId {
    final $_column = $_itemColumn<String>('class_id')!;

    final manager = $$UniversityClassTableTableManager(
      $_db,
      $_db.universityClass,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TeacherTableFilterComposer
    extends Composer<_$AppDatabase, $TeacherTable> {
  $$TeacherTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$UniversityClassTableFilterComposer get classId {
    final $$UniversityClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableFilterComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeacherTableOrderingComposer
    extends Composer<_$AppDatabase, $TeacherTable> {
  $$TeacherTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$UniversityClassTableOrderingComposer get classId {
    final $$UniversityClassTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableOrderingComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeacherTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeacherTable> {
  $$TeacherTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$UniversityClassTableAnnotationComposer get classId {
    final $$UniversityClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableAnnotationComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeacherTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeacherTable,
          TeacherData,
          $$TeacherTableFilterComposer,
          $$TeacherTableOrderingComposer,
          $$TeacherTableAnnotationComposer,
          $$TeacherTableCreateCompanionBuilder,
          $$TeacherTableUpdateCompanionBuilder,
          (TeacherData, $$TeacherTableReferences),
          TeacherData,
          PrefetchHooks Function({bool classId})
        > {
  $$TeacherTableTableManager(_$AppDatabase db, $TeacherTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeacherTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeacherTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeacherTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> classId = const Value.absent(),
              }) => TeacherCompanion(id: id, name: name, classId: classId),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String classId,
              }) =>
                  TeacherCompanion.insert(id: id, name: name, classId: classId),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeacherTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({classId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (classId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.classId,
                                referencedTable: $$TeacherTableReferences
                                    ._classIdTable(db),
                                referencedColumn: $$TeacherTableReferences
                                    ._classIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TeacherTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeacherTable,
      TeacherData,
      $$TeacherTableFilterComposer,
      $$TeacherTableOrderingComposer,
      $$TeacherTableAnnotationComposer,
      $$TeacherTableCreateCompanionBuilder,
      $$TeacherTableUpdateCompanionBuilder,
      (TeacherData, $$TeacherTableReferences),
      TeacherData,
      PrefetchHooks Function({bool classId})
    >;
typedef $$GroupTableCreateCompanionBuilder =
    GroupCompanion Function({
      Value<int> id,
      required String name,
      required String classId,
    });
typedef $$GroupTableUpdateCompanionBuilder =
    GroupCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> classId,
    });

final class $$GroupTableReferences
    extends BaseReferences<_$AppDatabase, $GroupTable, GroupData> {
  $$GroupTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UniversityClassTable _classIdTable(_$AppDatabase db) =>
      db.universityClass.createAlias(
        $_aliasNameGenerator(db.group.classId, db.universityClass.id),
      );

  $$UniversityClassTableProcessedTableManager get classId {
    final $_column = $_itemColumn<String>('class_id')!;

    final manager = $$UniversityClassTableTableManager(
      $_db,
      $_db.universityClass,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupTableFilterComposer extends Composer<_$AppDatabase, $GroupTable> {
  $$GroupTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$UniversityClassTableFilterComposer get classId {
    final $$UniversityClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableFilterComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupTable> {
  $$GroupTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$UniversityClassTableOrderingComposer get classId {
    final $$UniversityClassTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableOrderingComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupTable> {
  $$GroupTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$UniversityClassTableAnnotationComposer get classId {
    final $$UniversityClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.classId,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UniversityClassTableAnnotationComposer(
            $db: $db,
            $table: $db.universityClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupTable,
          GroupData,
          $$GroupTableFilterComposer,
          $$GroupTableOrderingComposer,
          $$GroupTableAnnotationComposer,
          $$GroupTableCreateCompanionBuilder,
          $$GroupTableUpdateCompanionBuilder,
          (GroupData, $$GroupTableReferences),
          GroupData,
          PrefetchHooks Function({bool classId})
        > {
  $$GroupTableTableManager(_$AppDatabase db, $GroupTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> classId = const Value.absent(),
              }) => GroupCompanion(id: id, name: name, classId: classId),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String classId,
              }) => GroupCompanion.insert(id: id, name: name, classId: classId),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GroupTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({classId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (classId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.classId,
                                referencedTable: $$GroupTableReferences
                                    ._classIdTable(db),
                                referencedColumn: $$GroupTableReferences
                                    ._classIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GroupTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupTable,
      GroupData,
      $$GroupTableFilterComposer,
      $$GroupTableOrderingComposer,
      $$GroupTableAnnotationComposer,
      $$GroupTableCreateCompanionBuilder,
      $$GroupTableUpdateCompanionBuilder,
      (GroupData, $$GroupTableReferences),
      GroupData,
      PrefetchHooks Function({bool classId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UniversityClassTableTableManager get universityClass =>
      $$UniversityClassTableTableManager(_db, _db.universityClass);
  $$TeacherTableTableManager get teacher =>
      $$TeacherTableTableManager(_db, _db.teacher);
  $$GroupTableTableManager get group =>
      $$GroupTableTableManager(_db, _db.group);
}
