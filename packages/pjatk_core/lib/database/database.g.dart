// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name},
  ];
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
    );
  }

  @override
  $TeacherTable createAlias(String alias) {
    return $TeacherTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class TeacherData extends DataClass implements Insertable<TeacherData> {
  final int id;
  final String name;
  const TeacherData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TeacherCompanion toCompanion(bool nullToAbsent) {
    return TeacherCompanion(id: Value(id), name: Value(name));
  }

  factory TeacherData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TeacherData copyWith({int? id, String? name}) =>
      TeacherData(id: id ?? this.id, name: name ?? this.name);
  TeacherData copyWithCompanion(TeacherCompanion data) {
    return TeacherData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherData && other.id == this.id && other.name == this.name);
}

class TeacherCompanion extends UpdateCompanion<TeacherData> {
  final Value<int> id;
  final Value<String> name;
  const TeacherCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TeacherCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TeacherData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TeacherCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TeacherCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name},
  ];
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
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String name;
  const GroupData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(id: Value(id), name: Value(name));
  }

  factory GroupData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  GroupData copyWith({int? id, String? name}) =>
      GroupData(id: id ?? this.id, name: name ?? this.name);
  GroupData copyWithCompanion(GroupCompanion data) {
    return GroupData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData && other.id == this.id && other.name == this.name);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String> name;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  GroupCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  GroupCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return GroupCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SubjectTable extends Subject with TableInfo<$SubjectTable, SubjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<ClassKind>($SubjectTable.$converterkind);
  static const VerificationMeta _ignoredMeta = const VerificationMeta(
    'ignored',
  );
  @override
  late final GeneratedColumn<bool> ignored = GeneratedColumn<bool>(
    'ignored',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ignored" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, code, kind, ignored];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subject';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubjectData> instance, {
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
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('ignored')) {
      context.handle(
        _ignoredMeta,
        ignored.isAcceptableOrUnknown(data['ignored']!, _ignoredMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name, code, kind},
  ];
  @override
  SubjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
      kind: $SubjectTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      ignored: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ignored'],
      )!,
    );
  }

  @override
  $SubjectTable createAlias(String alias) {
    return $SubjectTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ClassKind, String, String> $converterkind =
      const EnumNameConverter<ClassKind>(ClassKind.values);
}

class SubjectData extends DataClass implements Insertable<SubjectData> {
  final int id;
  final String name;
  final String code;
  final ClassKind kind;
  final bool ignored;
  const SubjectData({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    required this.ignored,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    {
      map['kind'] = Variable<String>($SubjectTable.$converterkind.toSql(kind));
    }
    map['ignored'] = Variable<bool>(ignored);
    return map;
  }

  SubjectCompanion toCompanion(bool nullToAbsent) {
    return SubjectCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      kind: Value(kind),
      ignored: Value(ignored),
    );
  }

  factory SubjectData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      kind: $SubjectTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      ignored: serializer.fromJson<bool>(json['ignored']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'kind': serializer.toJson<String>(
        $SubjectTable.$converterkind.toJson(kind),
      ),
      'ignored': serializer.toJson<bool>(ignored),
    };
  }

  SubjectData copyWith({
    int? id,
    String? name,
    String? code,
    ClassKind? kind,
    bool? ignored,
  }) => SubjectData(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    kind: kind ?? this.kind,
    ignored: ignored ?? this.ignored,
  );
  SubjectData copyWithCompanion(SubjectCompanion data) {
    return SubjectData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      kind: data.kind.present ? data.kind.value : this.kind,
      ignored: data.ignored.present ? data.ignored.value : this.ignored,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubjectData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('kind: $kind, ')
          ..write('ignored: $ignored')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, code, kind, ignored);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectData &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.kind == this.kind &&
          other.ignored == this.ignored);
}

class SubjectCompanion extends UpdateCompanion<SubjectData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> code;
  final Value<ClassKind> kind;
  final Value<bool> ignored;
  const SubjectCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.kind = const Value.absent(),
    this.ignored = const Value.absent(),
  });
  SubjectCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String code,
    required ClassKind kind,
    this.ignored = const Value.absent(),
  }) : name = Value(name),
       code = Value(code),
       kind = Value(kind);
  static Insertable<SubjectData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? kind,
    Expression<bool>? ignored,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (kind != null) 'kind': kind,
      if (ignored != null) 'ignored': ignored,
    });
  }

  SubjectCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? code,
    Value<ClassKind>? kind,
    Value<bool>? ignored,
  }) {
    return SubjectCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      kind: kind ?? this.kind,
      ignored: ignored ?? this.ignored,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $SubjectTable.$converterkind.toSql(kind.value),
      );
    }
    if (ignored.present) {
      map['ignored'] = Variable<bool>(ignored.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('kind: $kind, ')
          ..write('ignored: $ignored')
          ..write(')'))
        .toString();
  }
}

class $ClassAppointmentTable extends ClassAppointment
    with TableInfo<$ClassAppointmentTable, ClassAppointmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassAppointmentTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subject (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 256,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    location,
    startTime,
    endTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_appointment';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassAppointmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subjectId, startTime, endTime, location},
  ];
  @override
  ClassAppointmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassAppointmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
    );
  }

  @override
  $ClassAppointmentTable createAlias(String alias) {
    return $ClassAppointmentTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class ClassAppointmentData extends DataClass
    implements Insertable<ClassAppointmentData> {
  final int id;
  final int subjectId;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  const ClassAppointmentData({
    required this.id,
    required this.subjectId,
    required this.location,
    required this.startTime,
    required this.endTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['location'] = Variable<String>(location);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    return map;
  }

  ClassAppointmentCompanion toCompanion(bool nullToAbsent) {
    return ClassAppointmentCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      location: Value(location),
      startTime: Value(startTime),
      endTime: Value(endTime),
    );
  }

  factory ClassAppointmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassAppointmentData(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      location: serializer.fromJson<String>(json['location']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'location': serializer.toJson<String>(location),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
    };
  }

  ClassAppointmentData copyWith({
    int? id,
    int? subjectId,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
  }) => ClassAppointmentData(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    location: location ?? this.location,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );
  ClassAppointmentData copyWithCompanion(ClassAppointmentCompanion data) {
    return ClassAppointmentData(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      location: data.location.present ? data.location.value : this.location,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassAppointmentData(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('location: $location, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subjectId, location, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassAppointmentData &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.location == this.location &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class ClassAppointmentCompanion extends UpdateCompanion<ClassAppointmentData> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<String> location;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  const ClassAppointmentCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.location = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  ClassAppointmentCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required String location,
    required DateTime startTime,
    required DateTime endTime,
  }) : subjectId = Value(subjectId),
       location = Value(location),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<ClassAppointmentData> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<String>? location,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (location != null) 'location': location,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  ClassAppointmentCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<String>? location,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
  }) {
    return ClassAppointmentCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassAppointmentCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('location: $location, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $ClassGroupTable extends ClassGroup
    with TableInfo<$ClassGroupTable, ClassGroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassGroupTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "group" (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _appointmentIdMeta = const VerificationMeta(
    'appointmentId',
  );
  @override
  late final GeneratedColumn<int> appointmentId = GeneratedColumn<int>(
    'appointment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES class_appointment (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [groupId, appointmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_group';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassGroupData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('appointment_id')) {
      context.handle(
        _appointmentIdMeta,
        appointmentId.isAcceptableOrUnknown(
          data['appointment_id']!,
          _appointmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, appointmentId};
  @override
  ClassGroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassGroupData(
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      appointmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}appointment_id'],
      )!,
    );
  }

  @override
  $ClassGroupTable createAlias(String alias) {
    return $ClassGroupTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class ClassGroupData extends DataClass implements Insertable<ClassGroupData> {
  final int groupId;
  final int appointmentId;
  const ClassGroupData({required this.groupId, required this.appointmentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<int>(groupId);
    map['appointment_id'] = Variable<int>(appointmentId);
    return map;
  }

  ClassGroupCompanion toCompanion(bool nullToAbsent) {
    return ClassGroupCompanion(
      groupId: Value(groupId),
      appointmentId: Value(appointmentId),
    );
  }

  factory ClassGroupData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassGroupData(
      groupId: serializer.fromJson<int>(json['groupId']),
      appointmentId: serializer.fromJson<int>(json['appointmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<int>(groupId),
      'appointmentId': serializer.toJson<int>(appointmentId),
    };
  }

  ClassGroupData copyWith({int? groupId, int? appointmentId}) => ClassGroupData(
    groupId: groupId ?? this.groupId,
    appointmentId: appointmentId ?? this.appointmentId,
  );
  ClassGroupData copyWithCompanion(ClassGroupCompanion data) {
    return ClassGroupData(
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      appointmentId: data.appointmentId.present
          ? data.appointmentId.value
          : this.appointmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroupData(')
          ..write('groupId: $groupId, ')
          ..write('appointmentId: $appointmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, appointmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassGroupData &&
          other.groupId == this.groupId &&
          other.appointmentId == this.appointmentId);
}

class ClassGroupCompanion extends UpdateCompanion<ClassGroupData> {
  final Value<int> groupId;
  final Value<int> appointmentId;
  final Value<int> rowid;
  const ClassGroupCompanion({
    this.groupId = const Value.absent(),
    this.appointmentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassGroupCompanion.insert({
    required int groupId,
    required int appointmentId,
    this.rowid = const Value.absent(),
  }) : groupId = Value(groupId),
       appointmentId = Value(appointmentId);
  static Insertable<ClassGroupData> custom({
    Expression<int>? groupId,
    Expression<int>? appointmentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (appointmentId != null) 'appointment_id': appointmentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassGroupCompanion copyWith({
    Value<int>? groupId,
    Value<int>? appointmentId,
    Value<int>? rowid,
  }) {
    return ClassGroupCompanion(
      groupId: groupId ?? this.groupId,
      appointmentId: appointmentId ?? this.appointmentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (appointmentId.present) {
      map['appointment_id'] = Variable<int>(appointmentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroupCompanion(')
          ..write('groupId: $groupId, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassTeacherTable extends ClassTeacher
    with TableInfo<$ClassTeacherTable, ClassTeacherData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassTeacherTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<int> teacherId = GeneratedColumn<int>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teacher (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _appointmentIdMeta = const VerificationMeta(
    'appointmentId',
  );
  @override
  late final GeneratedColumn<int> appointmentId = GeneratedColumn<int>(
    'appointment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES class_appointment (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [teacherId, appointmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_teacher';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassTeacherData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('appointment_id')) {
      context.handle(
        _appointmentIdMeta,
        appointmentId.isAcceptableOrUnknown(
          data['appointment_id']!,
          _appointmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teacherId, appointmentId};
  @override
  ClassTeacherData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassTeacherData(
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teacher_id'],
      )!,
      appointmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}appointment_id'],
      )!,
    );
  }

  @override
  $ClassTeacherTable createAlias(String alias) {
    return $ClassTeacherTable(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
}

class ClassTeacherData extends DataClass
    implements Insertable<ClassTeacherData> {
  final int teacherId;
  final int appointmentId;
  const ClassTeacherData({
    required this.teacherId,
    required this.appointmentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['teacher_id'] = Variable<int>(teacherId);
    map['appointment_id'] = Variable<int>(appointmentId);
    return map;
  }

  ClassTeacherCompanion toCompanion(bool nullToAbsent) {
    return ClassTeacherCompanion(
      teacherId: Value(teacherId),
      appointmentId: Value(appointmentId),
    );
  }

  factory ClassTeacherData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassTeacherData(
      teacherId: serializer.fromJson<int>(json['teacherId']),
      appointmentId: serializer.fromJson<int>(json['appointmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teacherId': serializer.toJson<int>(teacherId),
      'appointmentId': serializer.toJson<int>(appointmentId),
    };
  }

  ClassTeacherData copyWith({int? teacherId, int? appointmentId}) =>
      ClassTeacherData(
        teacherId: teacherId ?? this.teacherId,
        appointmentId: appointmentId ?? this.appointmentId,
      );
  ClassTeacherData copyWithCompanion(ClassTeacherCompanion data) {
    return ClassTeacherData(
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      appointmentId: data.appointmentId.present
          ? data.appointmentId.value
          : this.appointmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassTeacherData(')
          ..write('teacherId: $teacherId, ')
          ..write('appointmentId: $appointmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teacherId, appointmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassTeacherData &&
          other.teacherId == this.teacherId &&
          other.appointmentId == this.appointmentId);
}

class ClassTeacherCompanion extends UpdateCompanion<ClassTeacherData> {
  final Value<int> teacherId;
  final Value<int> appointmentId;
  final Value<int> rowid;
  const ClassTeacherCompanion({
    this.teacherId = const Value.absent(),
    this.appointmentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassTeacherCompanion.insert({
    required int teacherId,
    required int appointmentId,
    this.rowid = const Value.absent(),
  }) : teacherId = Value(teacherId),
       appointmentId = Value(appointmentId);
  static Insertable<ClassTeacherData> custom({
    Expression<int>? teacherId,
    Expression<int>? appointmentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teacherId != null) 'teacher_id': teacherId,
      if (appointmentId != null) 'appointment_id': appointmentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassTeacherCompanion copyWith({
    Value<int>? teacherId,
    Value<int>? appointmentId,
    Value<int>? rowid,
  }) {
    return ClassTeacherCompanion(
      teacherId: teacherId ?? this.teacherId,
      appointmentId: appointmentId ?? this.appointmentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teacherId.present) {
      map['teacher_id'] = Variable<int>(teacherId.value);
    }
    if (appointmentId.present) {
      map['appointment_id'] = Variable<int>(appointmentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassTeacherCompanion(')
          ..write('teacherId: $teacherId, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DayInfoTable extends DayInfo with TableInfo<$DayInfoTable, DayInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [date, lastUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DayInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayInfoData(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      lastUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update'],
      )!,
    );
  }

  @override
  $DayInfoTable createAlias(String alias) {
    return $DayInfoTable(attachedDatabase, alias);
  }
}

class DayInfoData extends DataClass implements Insertable<DayInfoData> {
  final DateTime date;
  final DateTime lastUpdate;
  const DayInfoData({required this.date, required this.lastUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  DayInfoCompanion toCompanion(bool nullToAbsent) {
    return DayInfoCompanion(date: Value(date), lastUpdate: Value(lastUpdate));
  }

  factory DayInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayInfoData(
      date: serializer.fromJson<DateTime>(json['date']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  DayInfoData copyWith({DateTime? date, DateTime? lastUpdate}) => DayInfoData(
    date: date ?? this.date,
    lastUpdate: lastUpdate ?? this.lastUpdate,
  );
  DayInfoData copyWithCompanion(DayInfoCompanion data) {
    return DayInfoData(
      date: data.date.present ? data.date.value : this.date,
      lastUpdate: data.lastUpdate.present
          ? data.lastUpdate.value
          : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayInfoData(')
          ..write('date: $date, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayInfoData &&
          other.date == this.date &&
          other.lastUpdate == this.lastUpdate);
}

class DayInfoCompanion extends UpdateCompanion<DayInfoData> {
  final Value<DateTime> date;
  final Value<DateTime> lastUpdate;
  final Value<int> rowid;
  const DayInfoCompanion({
    this.date = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayInfoCompanion.insert({
    required DateTime date,
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DayInfoData> custom({
    Expression<DateTime>? date,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayInfoCompanion copyWith({
    Value<DateTime>? date,
    Value<DateTime>? lastUpdate,
    Value<int>? rowid,
  }) {
    return DayInfoCompanion(
      date: date ?? this.date,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayInfoCompanion(')
          ..write('date: $date, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ScheduleDatabase extends GeneratedDatabase {
  _$ScheduleDatabase(QueryExecutor e) : super(e);
  $ScheduleDatabaseManager get managers => $ScheduleDatabaseManager(this);
  late final $TeacherTable teacher = $TeacherTable(this);
  late final $GroupTable group = $GroupTable(this);
  late final $SubjectTable subject = $SubjectTable(this);
  late final $ClassAppointmentTable classAppointment = $ClassAppointmentTable(
    this,
  );
  late final $ClassGroupTable classGroup = $ClassGroupTable(this);
  late final $ClassTeacherTable classTeacher = $ClassTeacherTable(this);
  late final $DayInfoTable dayInfo = $DayInfoTable(this);
  late final Index appointmentStart = Index(
    'appointment_start',
    'CREATE INDEX appointment_start ON class_appointment (start_time)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teacher,
    group,
    subject,
    classAppointment,
    classGroup,
    classTeacher,
    dayInfo,
    appointmentStart,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subject',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('class_appointment', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subject',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('class_appointment', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'group',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('class_group', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'group',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('class_group', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'class_appointment',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('class_group', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'class_appointment',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('class_group', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teacher',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('class_teacher', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teacher',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('class_teacher', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'class_appointment',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('class_teacher', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'class_appointment',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('class_teacher', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$TeacherTableCreateCompanionBuilder =
    TeacherCompanion Function({Value<int> id, required String name});
typedef $$TeacherTableUpdateCompanionBuilder =
    TeacherCompanion Function({Value<int> id, Value<String> name});

final class $$TeacherTableReferences
    extends BaseReferences<_$ScheduleDatabase, $TeacherTable, TeacherData> {
  $$TeacherTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClassTeacherTable, List<ClassTeacherData>>
  _classTeacherRefsTable(_$ScheduleDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.classTeacher,
        aliasName: $_aliasNameGenerator(
          db.teacher.id,
          db.classTeacher.teacherId,
        ),
      );

  $$ClassTeacherTableProcessedTableManager get classTeacherRefs {
    final manager = $$ClassTeacherTableTableManager(
      $_db,
      $_db.classTeacher,
    ).filter((f) => f.teacherId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classTeacherRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeacherTableFilterComposer
    extends Composer<_$ScheduleDatabase, $TeacherTable> {
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

  Expression<bool> classTeacherRefs(
    Expression<bool> Function($$ClassTeacherTableFilterComposer f) f,
  ) {
    final $$ClassTeacherTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classTeacher,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassTeacherTableFilterComposer(
            $db: $db,
            $table: $db.classTeacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeacherTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $TeacherTable> {
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
}

class $$TeacherTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $TeacherTable> {
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

  Expression<T> classTeacherRefs<T extends Object>(
    Expression<T> Function($$ClassTeacherTableAnnotationComposer a) f,
  ) {
    final $$ClassTeacherTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classTeacher,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassTeacherTableAnnotationComposer(
            $db: $db,
            $table: $db.classTeacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeacherTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $TeacherTable,
          TeacherData,
          $$TeacherTableFilterComposer,
          $$TeacherTableOrderingComposer,
          $$TeacherTableAnnotationComposer,
          $$TeacherTableCreateCompanionBuilder,
          $$TeacherTableUpdateCompanionBuilder,
          (TeacherData, $$TeacherTableReferences),
          TeacherData,
          PrefetchHooks Function({bool classTeacherRefs})
        > {
  $$TeacherTableTableManager(_$ScheduleDatabase db, $TeacherTable table)
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
              }) => TeacherCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  TeacherCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeacherTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({classTeacherRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (classTeacherRefs) db.classTeacher],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (classTeacherRefs)
                    await $_getPrefetchedData<
                      TeacherData,
                      $TeacherTable,
                      ClassTeacherData
                    >(
                      currentTable: table,
                      referencedTable: $$TeacherTableReferences
                          ._classTeacherRefsTable(db),
                      managerFromTypedResult: (p0) => $$TeacherTableReferences(
                        db,
                        table,
                        p0,
                      ).classTeacherRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.teacherId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TeacherTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $TeacherTable,
      TeacherData,
      $$TeacherTableFilterComposer,
      $$TeacherTableOrderingComposer,
      $$TeacherTableAnnotationComposer,
      $$TeacherTableCreateCompanionBuilder,
      $$TeacherTableUpdateCompanionBuilder,
      (TeacherData, $$TeacherTableReferences),
      TeacherData,
      PrefetchHooks Function({bool classTeacherRefs})
    >;
typedef $$GroupTableCreateCompanionBuilder =
    GroupCompanion Function({Value<int> id, required String name});
typedef $$GroupTableUpdateCompanionBuilder =
    GroupCompanion Function({Value<int> id, Value<String> name});

final class $$GroupTableReferences
    extends BaseReferences<_$ScheduleDatabase, $GroupTable, GroupData> {
  $$GroupTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClassGroupTable, List<ClassGroupData>>
  _classGroupRefsTable(_$ScheduleDatabase db) => MultiTypedResultKey.fromTable(
    db.classGroup,
    aliasName: $_aliasNameGenerator(db.group.id, db.classGroup.groupId),
  );

  $$ClassGroupTableProcessedTableManager get classGroupRefs {
    final manager = $$ClassGroupTableTableManager(
      $_db,
      $_db.classGroup,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classGroupRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupTableFilterComposer
    extends Composer<_$ScheduleDatabase, $GroupTable> {
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

  Expression<bool> classGroupRefs(
    Expression<bool> Function($$ClassGroupTableFilterComposer f) f,
  ) {
    final $$ClassGroupTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassGroupTableFilterComposer(
            $db: $db,
            $table: $db.classGroup,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $GroupTable> {
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
}

class $$GroupTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $GroupTable> {
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

  Expression<T> classGroupRefs<T extends Object>(
    Expression<T> Function($$ClassGroupTableAnnotationComposer a) f,
  ) {
    final $$ClassGroupTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassGroupTableAnnotationComposer(
            $db: $db,
            $table: $db.classGroup,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $GroupTable,
          GroupData,
          $$GroupTableFilterComposer,
          $$GroupTableOrderingComposer,
          $$GroupTableAnnotationComposer,
          $$GroupTableCreateCompanionBuilder,
          $$GroupTableUpdateCompanionBuilder,
          (GroupData, $$GroupTableReferences),
          GroupData,
          PrefetchHooks Function({bool classGroupRefs})
        > {
  $$GroupTableTableManager(_$ScheduleDatabase db, $GroupTable table)
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
              }) => GroupCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  GroupCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GroupTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({classGroupRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (classGroupRefs) db.classGroup],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (classGroupRefs)
                    await $_getPrefetchedData<
                      GroupData,
                      $GroupTable,
                      ClassGroupData
                    >(
                      currentTable: table,
                      referencedTable: $$GroupTableReferences
                          ._classGroupRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GroupTableReferences(db, table, p0).classGroupRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GroupTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $GroupTable,
      GroupData,
      $$GroupTableFilterComposer,
      $$GroupTableOrderingComposer,
      $$GroupTableAnnotationComposer,
      $$GroupTableCreateCompanionBuilder,
      $$GroupTableUpdateCompanionBuilder,
      (GroupData, $$GroupTableReferences),
      GroupData,
      PrefetchHooks Function({bool classGroupRefs})
    >;
typedef $$SubjectTableCreateCompanionBuilder =
    SubjectCompanion Function({
      Value<int> id,
      required String name,
      required String code,
      required ClassKind kind,
      Value<bool> ignored,
    });
typedef $$SubjectTableUpdateCompanionBuilder =
    SubjectCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> code,
      Value<ClassKind> kind,
      Value<bool> ignored,
    });

final class $$SubjectTableReferences
    extends BaseReferences<_$ScheduleDatabase, $SubjectTable, SubjectData> {
  $$SubjectTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClassAppointmentTable, List<ClassAppointmentData>>
  _classAppointmentRefsTable(_$ScheduleDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.classAppointment,
        aliasName: $_aliasNameGenerator(
          db.subject.id,
          db.classAppointment.subjectId,
        ),
      );

  $$ClassAppointmentTableProcessedTableManager get classAppointmentRefs {
    final manager = $$ClassAppointmentTableTableManager(
      $_db,
      $_db.classAppointment,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _classAppointmentRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectTableFilterComposer
    extends Composer<_$ScheduleDatabase, $SubjectTable> {
  $$SubjectTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ClassKind, ClassKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get ignored => $composableBuilder(
    column: $table.ignored,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> classAppointmentRefs(
    Expression<bool> Function($$ClassAppointmentTableFilterComposer f) f,
  ) {
    final $$ClassAppointmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableFilterComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $SubjectTable> {
  $$SubjectTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ignored => $composableBuilder(
    column: $table.ignored,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $SubjectTable> {
  $$SubjectTableAnnotationComposer({
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

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ClassKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get ignored =>
      $composableBuilder(column: $table.ignored, builder: (column) => column);

  Expression<T> classAppointmentRefs<T extends Object>(
    Expression<T> Function($$ClassAppointmentTableAnnotationComposer a) f,
  ) {
    final $$ClassAppointmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableAnnotationComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $SubjectTable,
          SubjectData,
          $$SubjectTableFilterComposer,
          $$SubjectTableOrderingComposer,
          $$SubjectTableAnnotationComposer,
          $$SubjectTableCreateCompanionBuilder,
          $$SubjectTableUpdateCompanionBuilder,
          (SubjectData, $$SubjectTableReferences),
          SubjectData,
          PrefetchHooks Function({bool classAppointmentRefs})
        > {
  $$SubjectTableTableManager(_$ScheduleDatabase db, $SubjectTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<ClassKind> kind = const Value.absent(),
                Value<bool> ignored = const Value.absent(),
              }) => SubjectCompanion(
                id: id,
                name: name,
                code: code,
                kind: kind,
                ignored: ignored,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String code,
                required ClassKind kind,
                Value<bool> ignored = const Value.absent(),
              }) => SubjectCompanion.insert(
                id: id,
                name: name,
                code: code,
                kind: kind,
                ignored: ignored,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubjectTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({classAppointmentRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (classAppointmentRefs) db.classAppointment,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (classAppointmentRefs)
                    await $_getPrefetchedData<
                      SubjectData,
                      $SubjectTable,
                      ClassAppointmentData
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectTableReferences
                          ._classAppointmentRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectTableReferences(
                        db,
                        table,
                        p0,
                      ).classAppointmentRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubjectTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $SubjectTable,
      SubjectData,
      $$SubjectTableFilterComposer,
      $$SubjectTableOrderingComposer,
      $$SubjectTableAnnotationComposer,
      $$SubjectTableCreateCompanionBuilder,
      $$SubjectTableUpdateCompanionBuilder,
      (SubjectData, $$SubjectTableReferences),
      SubjectData,
      PrefetchHooks Function({bool classAppointmentRefs})
    >;
typedef $$ClassAppointmentTableCreateCompanionBuilder =
    ClassAppointmentCompanion Function({
      Value<int> id,
      required int subjectId,
      required String location,
      required DateTime startTime,
      required DateTime endTime,
    });
typedef $$ClassAppointmentTableUpdateCompanionBuilder =
    ClassAppointmentCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<String> location,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
    });

final class $$ClassAppointmentTableReferences
    extends
        BaseReferences<
          _$ScheduleDatabase,
          $ClassAppointmentTable,
          ClassAppointmentData
        > {
  $$ClassAppointmentTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectTable _subjectIdTable(_$ScheduleDatabase db) =>
      db.subject.createAlias(
        $_aliasNameGenerator(db.classAppointment.subjectId, db.subject.id),
      );

  $$SubjectTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectTableTableManager(
      $_db,
      $_db.subject,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ClassGroupTable, List<ClassGroupData>>
  _classGroupRefsTable(_$ScheduleDatabase db) => MultiTypedResultKey.fromTable(
    db.classGroup,
    aliasName: $_aliasNameGenerator(
      db.classAppointment.id,
      db.classGroup.appointmentId,
    ),
  );

  $$ClassGroupTableProcessedTableManager get classGroupRefs {
    final manager = $$ClassGroupTableTableManager(
      $_db,
      $_db.classGroup,
    ).filter((f) => f.appointmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classGroupRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClassTeacherTable, List<ClassTeacherData>>
  _classTeacherRefsTable(_$ScheduleDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.classTeacher,
        aliasName: $_aliasNameGenerator(
          db.classAppointment.id,
          db.classTeacher.appointmentId,
        ),
      );

  $$ClassTeacherTableProcessedTableManager get classTeacherRefs {
    final manager = $$ClassTeacherTableTableManager(
      $_db,
      $_db.classTeacher,
    ).filter((f) => f.appointmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_classTeacherRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClassAppointmentTableFilterComposer
    extends Composer<_$ScheduleDatabase, $ClassAppointmentTable> {
  $$ClassAppointmentTableFilterComposer({
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

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectTableFilterComposer get subjectId {
    final $$SubjectTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subject,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectTableFilterComposer(
            $db: $db,
            $table: $db.subject,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> classGroupRefs(
    Expression<bool> Function($$ClassGroupTableFilterComposer f) f,
  ) {
    final $$ClassGroupTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.appointmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassGroupTableFilterComposer(
            $db: $db,
            $table: $db.classGroup,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> classTeacherRefs(
    Expression<bool> Function($$ClassTeacherTableFilterComposer f) f,
  ) {
    final $$ClassTeacherTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classTeacher,
      getReferencedColumn: (t) => t.appointmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassTeacherTableFilterComposer(
            $db: $db,
            $table: $db.classTeacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClassAppointmentTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $ClassAppointmentTable> {
  $$ClassAppointmentTableOrderingComposer({
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

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
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

  $$SubjectTableOrderingComposer get subjectId {
    final $$SubjectTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subject,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectTableOrderingComposer(
            $db: $db,
            $table: $db.subject,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassAppointmentTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $ClassAppointmentTable> {
  $$ClassAppointmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  $$SubjectTableAnnotationComposer get subjectId {
    final $$SubjectTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subject,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectTableAnnotationComposer(
            $db: $db,
            $table: $db.subject,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> classGroupRefs<T extends Object>(
    Expression<T> Function($$ClassGroupTableAnnotationComposer a) f,
  ) {
    final $$ClassGroupTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.appointmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassGroupTableAnnotationComposer(
            $db: $db,
            $table: $db.classGroup,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> classTeacherRefs<T extends Object>(
    Expression<T> Function($$ClassTeacherTableAnnotationComposer a) f,
  ) {
    final $$ClassTeacherTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classTeacher,
      getReferencedColumn: (t) => t.appointmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassTeacherTableAnnotationComposer(
            $db: $db,
            $table: $db.classTeacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClassAppointmentTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $ClassAppointmentTable,
          ClassAppointmentData,
          $$ClassAppointmentTableFilterComposer,
          $$ClassAppointmentTableOrderingComposer,
          $$ClassAppointmentTableAnnotationComposer,
          $$ClassAppointmentTableCreateCompanionBuilder,
          $$ClassAppointmentTableUpdateCompanionBuilder,
          (ClassAppointmentData, $$ClassAppointmentTableReferences),
          ClassAppointmentData,
          PrefetchHooks Function({
            bool subjectId,
            bool classGroupRefs,
            bool classTeacherRefs,
          })
        > {
  $$ClassAppointmentTableTableManager(
    _$ScheduleDatabase db,
    $ClassAppointmentTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassAppointmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassAppointmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassAppointmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
              }) => ClassAppointmentCompanion(
                id: id,
                subjectId: subjectId,
                location: location,
                startTime: startTime,
                endTime: endTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required String location,
                required DateTime startTime,
                required DateTime endTime,
              }) => ClassAppointmentCompanion.insert(
                id: id,
                subjectId: subjectId,
                location: location,
                startTime: startTime,
                endTime: endTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClassAppointmentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                classGroupRefs = false,
                classTeacherRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (classGroupRefs) db.classGroup,
                    if (classTeacherRefs) db.classTeacher,
                  ],
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
                        if (subjectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.subjectId,
                                    referencedTable:
                                        $$ClassAppointmentTableReferences
                                            ._subjectIdTable(db),
                                    referencedColumn:
                                        $$ClassAppointmentTableReferences
                                            ._subjectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (classGroupRefs)
                        await $_getPrefetchedData<
                          ClassAppointmentData,
                          $ClassAppointmentTable,
                          ClassGroupData
                        >(
                          currentTable: table,
                          referencedTable: $$ClassAppointmentTableReferences
                              ._classGroupRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClassAppointmentTableReferences(
                                db,
                                table,
                                p0,
                              ).classGroupRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.appointmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (classTeacherRefs)
                        await $_getPrefetchedData<
                          ClassAppointmentData,
                          $ClassAppointmentTable,
                          ClassTeacherData
                        >(
                          currentTable: table,
                          referencedTable: $$ClassAppointmentTableReferences
                              ._classTeacherRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClassAppointmentTableReferences(
                                db,
                                table,
                                p0,
                              ).classTeacherRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.appointmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClassAppointmentTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $ClassAppointmentTable,
      ClassAppointmentData,
      $$ClassAppointmentTableFilterComposer,
      $$ClassAppointmentTableOrderingComposer,
      $$ClassAppointmentTableAnnotationComposer,
      $$ClassAppointmentTableCreateCompanionBuilder,
      $$ClassAppointmentTableUpdateCompanionBuilder,
      (ClassAppointmentData, $$ClassAppointmentTableReferences),
      ClassAppointmentData,
      PrefetchHooks Function({
        bool subjectId,
        bool classGroupRefs,
        bool classTeacherRefs,
      })
    >;
typedef $$ClassGroupTableCreateCompanionBuilder =
    ClassGroupCompanion Function({
      required int groupId,
      required int appointmentId,
      Value<int> rowid,
    });
typedef $$ClassGroupTableUpdateCompanionBuilder =
    ClassGroupCompanion Function({
      Value<int> groupId,
      Value<int> appointmentId,
      Value<int> rowid,
    });

final class $$ClassGroupTableReferences
    extends
        BaseReferences<_$ScheduleDatabase, $ClassGroupTable, ClassGroupData> {
  $$ClassGroupTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupTable _groupIdTable(_$ScheduleDatabase db) => db.group
      .createAlias($_aliasNameGenerator(db.classGroup.groupId, db.group.id));

  $$GroupTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupTableTableManager(
      $_db,
      $_db.group,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClassAppointmentTable _appointmentIdTable(_$ScheduleDatabase db) =>
      db.classAppointment.createAlias(
        $_aliasNameGenerator(
          db.classGroup.appointmentId,
          db.classAppointment.id,
        ),
      );

  $$ClassAppointmentTableProcessedTableManager get appointmentId {
    final $_column = $_itemColumn<int>('appointment_id')!;

    final manager = $$ClassAppointmentTableTableManager(
      $_db,
      $_db.classAppointment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_appointmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ClassGroupTableFilterComposer
    extends Composer<_$ScheduleDatabase, $ClassGroupTable> {
  $$ClassGroupTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableFilterComposer get groupId {
    final $$GroupTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.group,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$ClassAppointmentTableFilterComposer get appointmentId {
    final $$ClassAppointmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableFilterComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassGroupTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $ClassGroupTable> {
  $$ClassGroupTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableOrderingComposer get groupId {
    final $$GroupTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.group,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableOrderingComposer(
            $db: $db,
            $table: $db.group,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClassAppointmentTableOrderingComposer get appointmentId {
    final $$ClassAppointmentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableOrderingComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassGroupTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $ClassGroupTable> {
  $$ClassGroupTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableAnnotationComposer get groupId {
    final $$GroupTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.group,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$ClassAppointmentTableAnnotationComposer get appointmentId {
    final $$ClassAppointmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableAnnotationComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassGroupTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $ClassGroupTable,
          ClassGroupData,
          $$ClassGroupTableFilterComposer,
          $$ClassGroupTableOrderingComposer,
          $$ClassGroupTableAnnotationComposer,
          $$ClassGroupTableCreateCompanionBuilder,
          $$ClassGroupTableUpdateCompanionBuilder,
          (ClassGroupData, $$ClassGroupTableReferences),
          ClassGroupData,
          PrefetchHooks Function({bool groupId, bool appointmentId})
        > {
  $$ClassGroupTableTableManager(_$ScheduleDatabase db, $ClassGroupTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassGroupTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassGroupTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassGroupTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> groupId = const Value.absent(),
                Value<int> appointmentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassGroupCompanion(
                groupId: groupId,
                appointmentId: appointmentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int groupId,
                required int appointmentId,
                Value<int> rowid = const Value.absent(),
              }) => ClassGroupCompanion.insert(
                groupId: groupId,
                appointmentId: appointmentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClassGroupTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, appointmentId = false}) {
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
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $$ClassGroupTableReferences
                                    ._groupIdTable(db),
                                referencedColumn: $$ClassGroupTableReferences
                                    ._groupIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (appointmentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.appointmentId,
                                referencedTable: $$ClassGroupTableReferences
                                    ._appointmentIdTable(db),
                                referencedColumn: $$ClassGroupTableReferences
                                    ._appointmentIdTable(db)
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

typedef $$ClassGroupTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $ClassGroupTable,
      ClassGroupData,
      $$ClassGroupTableFilterComposer,
      $$ClassGroupTableOrderingComposer,
      $$ClassGroupTableAnnotationComposer,
      $$ClassGroupTableCreateCompanionBuilder,
      $$ClassGroupTableUpdateCompanionBuilder,
      (ClassGroupData, $$ClassGroupTableReferences),
      ClassGroupData,
      PrefetchHooks Function({bool groupId, bool appointmentId})
    >;
typedef $$ClassTeacherTableCreateCompanionBuilder =
    ClassTeacherCompanion Function({
      required int teacherId,
      required int appointmentId,
      Value<int> rowid,
    });
typedef $$ClassTeacherTableUpdateCompanionBuilder =
    ClassTeacherCompanion Function({
      Value<int> teacherId,
      Value<int> appointmentId,
      Value<int> rowid,
    });

final class $$ClassTeacherTableReferences
    extends
        BaseReferences<
          _$ScheduleDatabase,
          $ClassTeacherTable,
          ClassTeacherData
        > {
  $$ClassTeacherTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TeacherTable _teacherIdTable(_$ScheduleDatabase db) =>
      db.teacher.createAlias(
        $_aliasNameGenerator(db.classTeacher.teacherId, db.teacher.id),
      );

  $$TeacherTableProcessedTableManager get teacherId {
    final $_column = $_itemColumn<int>('teacher_id')!;

    final manager = $$TeacherTableTableManager(
      $_db,
      $_db.teacher,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teacherIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClassAppointmentTable _appointmentIdTable(_$ScheduleDatabase db) =>
      db.classAppointment.createAlias(
        $_aliasNameGenerator(
          db.classTeacher.appointmentId,
          db.classAppointment.id,
        ),
      );

  $$ClassAppointmentTableProcessedTableManager get appointmentId {
    final $_column = $_itemColumn<int>('appointment_id')!;

    final manager = $$ClassAppointmentTableTableManager(
      $_db,
      $_db.classAppointment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_appointmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ClassTeacherTableFilterComposer
    extends Composer<_$ScheduleDatabase, $ClassTeacherTable> {
  $$ClassTeacherTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeacherTableFilterComposer get teacherId {
    final $$TeacherTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teacher,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$ClassAppointmentTableFilterComposer get appointmentId {
    final $$ClassAppointmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableFilterComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassTeacherTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $ClassTeacherTable> {
  $$ClassTeacherTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeacherTableOrderingComposer get teacherId {
    final $$TeacherTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teacher,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeacherTableOrderingComposer(
            $db: $db,
            $table: $db.teacher,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClassAppointmentTableOrderingComposer get appointmentId {
    final $$ClassAppointmentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableOrderingComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassTeacherTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $ClassTeacherTable> {
  $$ClassTeacherTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeacherTableAnnotationComposer get teacherId {
    final $$TeacherTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teacher,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$ClassAppointmentTableAnnotationComposer get appointmentId {
    final $$ClassAppointmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.appointmentId,
      referencedTable: $db.classAppointment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassAppointmentTableAnnotationComposer(
            $db: $db,
            $table: $db.classAppointment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClassTeacherTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $ClassTeacherTable,
          ClassTeacherData,
          $$ClassTeacherTableFilterComposer,
          $$ClassTeacherTableOrderingComposer,
          $$ClassTeacherTableAnnotationComposer,
          $$ClassTeacherTableCreateCompanionBuilder,
          $$ClassTeacherTableUpdateCompanionBuilder,
          (ClassTeacherData, $$ClassTeacherTableReferences),
          ClassTeacherData,
          PrefetchHooks Function({bool teacherId, bool appointmentId})
        > {
  $$ClassTeacherTableTableManager(
    _$ScheduleDatabase db,
    $ClassTeacherTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassTeacherTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassTeacherTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassTeacherTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> teacherId = const Value.absent(),
                Value<int> appointmentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassTeacherCompanion(
                teacherId: teacherId,
                appointmentId: appointmentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int teacherId,
                required int appointmentId,
                Value<int> rowid = const Value.absent(),
              }) => ClassTeacherCompanion.insert(
                teacherId: teacherId,
                appointmentId: appointmentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClassTeacherTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({teacherId = false, appointmentId = false}) {
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
                    if (teacherId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teacherId,
                                referencedTable: $$ClassTeacherTableReferences
                                    ._teacherIdTable(db),
                                referencedColumn: $$ClassTeacherTableReferences
                                    ._teacherIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (appointmentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.appointmentId,
                                referencedTable: $$ClassTeacherTableReferences
                                    ._appointmentIdTable(db),
                                referencedColumn: $$ClassTeacherTableReferences
                                    ._appointmentIdTable(db)
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

typedef $$ClassTeacherTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $ClassTeacherTable,
      ClassTeacherData,
      $$ClassTeacherTableFilterComposer,
      $$ClassTeacherTableOrderingComposer,
      $$ClassTeacherTableAnnotationComposer,
      $$ClassTeacherTableCreateCompanionBuilder,
      $$ClassTeacherTableUpdateCompanionBuilder,
      (ClassTeacherData, $$ClassTeacherTableReferences),
      ClassTeacherData,
      PrefetchHooks Function({bool teacherId, bool appointmentId})
    >;
typedef $$DayInfoTableCreateCompanionBuilder =
    DayInfoCompanion Function({
      required DateTime date,
      Value<DateTime> lastUpdate,
      Value<int> rowid,
    });
typedef $$DayInfoTableUpdateCompanionBuilder =
    DayInfoCompanion Function({
      Value<DateTime> date,
      Value<DateTime> lastUpdate,
      Value<int> rowid,
    });

class $$DayInfoTableFilterComposer
    extends Composer<_$ScheduleDatabase, $DayInfoTable> {
  $$DayInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayInfoTableOrderingComposer
    extends Composer<_$ScheduleDatabase, $DayInfoTable> {
  $$DayInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayInfoTableAnnotationComposer
    extends Composer<_$ScheduleDatabase, $DayInfoTable> {
  $$DayInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );
}

class $$DayInfoTableTableManager
    extends
        RootTableManager<
          _$ScheduleDatabase,
          $DayInfoTable,
          DayInfoData,
          $$DayInfoTableFilterComposer,
          $$DayInfoTableOrderingComposer,
          $$DayInfoTableAnnotationComposer,
          $$DayInfoTableCreateCompanionBuilder,
          $$DayInfoTableUpdateCompanionBuilder,
          (
            DayInfoData,
            BaseReferences<_$ScheduleDatabase, $DayInfoTable, DayInfoData>,
          ),
          DayInfoData,
          PrefetchHooks Function()
        > {
  $$DayInfoTableTableManager(_$ScheduleDatabase db, $DayInfoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayInfoCompanion(
                date: date,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayInfoCompanion.insert(
                date: date,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$ScheduleDatabase,
      $DayInfoTable,
      DayInfoData,
      $$DayInfoTableFilterComposer,
      $$DayInfoTableOrderingComposer,
      $$DayInfoTableAnnotationComposer,
      $$DayInfoTableCreateCompanionBuilder,
      $$DayInfoTableUpdateCompanionBuilder,
      (
        DayInfoData,
        BaseReferences<_$ScheduleDatabase, $DayInfoTable, DayInfoData>,
      ),
      DayInfoData,
      PrefetchHooks Function()
    >;

class $ScheduleDatabaseManager {
  final _$ScheduleDatabase _db;
  $ScheduleDatabaseManager(this._db);
  $$TeacherTableTableManager get teacher =>
      $$TeacherTableTableManager(_db, _db.teacher);
  $$GroupTableTableManager get group =>
      $$GroupTableTableManager(_db, _db.group);
  $$SubjectTableTableManager get subject =>
      $$SubjectTableTableManager(_db, _db.subject);
  $$ClassAppointmentTableTableManager get classAppointment =>
      $$ClassAppointmentTableTableManager(_db, _db.classAppointment);
  $$ClassGroupTableTableManager get classGroup =>
      $$ClassGroupTableTableManager(_db, _db.classGroup);
  $$ClassTeacherTableTableManager get classTeacher =>
      $$ClassTeacherTableTableManager(_db, _db.classTeacher);
  $$DayInfoTableTableManager get dayInfo =>
      $$DayInfoTableTableManager(_db, _db.dayInfo);
}
