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
      maxTextLength: 128,
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
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<int> teacherId = GeneratedColumn<int>(
    'teacher_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teacher (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, code, kind, room, teacherId];
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
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
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
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      ),
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teacher_id'],
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
  final String? room;
  final int? teacherId;
  const UniversityClassData({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    this.room,
    this.teacherId,
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
    if (!nullToAbsent || room != null) {
      map['room'] = Variable<String>(room);
    }
    if (!nullToAbsent || teacherId != null) {
      map['teacher_id'] = Variable<int>(teacherId);
    }
    return map;
  }

  UniversityClassCompanion toCompanion(bool nullToAbsent) {
    return UniversityClassCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      kind: Value(kind),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
      teacherId: teacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherId),
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
      room: serializer.fromJson<String?>(json['room']),
      teacherId: serializer.fromJson<int?>(json['teacherId']),
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
      'room': serializer.toJson<String?>(room),
      'teacherId': serializer.toJson<int?>(teacherId),
    };
  }

  UniversityClassData copyWith({
    String? id,
    String? name,
    String? code,
    ClassKind? kind,
    Value<String?> room = const Value.absent(),
    Value<int?> teacherId = const Value.absent(),
  }) => UniversityClassData(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    kind: kind ?? this.kind,
    room: room.present ? room.value : this.room,
    teacherId: teacherId.present ? teacherId.value : this.teacherId,
  );
  UniversityClassData copyWithCompanion(UniversityClassCompanion data) {
    return UniversityClassData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      kind: data.kind.present ? data.kind.value : this.kind,
      room: data.room.present ? data.room.value : this.room,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UniversityClassData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('kind: $kind, ')
          ..write('room: $room, ')
          ..write('teacherId: $teacherId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, code, kind, room, teacherId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UniversityClassData &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.kind == this.kind &&
          other.room == this.room &&
          other.teacherId == this.teacherId);
}

class UniversityClassCompanion extends UpdateCompanion<UniversityClassData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<ClassKind> kind;
  final Value<String?> room;
  final Value<int?> teacherId;
  final Value<int> rowid;
  const UniversityClassCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.kind = const Value.absent(),
    this.room = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UniversityClassCompanion.insert({
    required String id,
    required String name,
    required String code,
    required ClassKind kind,
    this.room = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       code = Value(code),
       kind = Value(kind);
  static Insertable<UniversityClassData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? kind,
    Expression<String>? room,
    Expression<int>? teacherId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (kind != null) 'kind': kind,
      if (room != null) 'room': room,
      if (teacherId != null) 'teacher_id': teacherId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UniversityClassCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? code,
    Value<ClassKind>? kind,
    Value<String?>? room,
    Value<int?>? teacherId,
    Value<int>? rowid,
  }) {
    return UniversityClassCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      kind: kind ?? this.kind,
      room: room ?? this.room,
      teacherId: teacherId ?? this.teacherId,
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
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<int>(teacherId.value);
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
          ..write('room: $room, ')
          ..write('teacherId: $teacherId, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES university_class (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, classId];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ClassGroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassGroupData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
    );
  }

  @override
  $ClassGroupTable createAlias(String alias) {
    return $ClassGroupTable(attachedDatabase, alias);
  }
}

class ClassGroupData extends DataClass implements Insertable<ClassGroupData> {
  final String id;
  final String classId;
  const ClassGroupData({required this.id, required this.classId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['class_id'] = Variable<String>(classId);
    return map;
  }

  ClassGroupCompanion toCompanion(bool nullToAbsent) {
    return ClassGroupCompanion(id: Value(id), classId: Value(classId));
  }

  factory ClassGroupData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassGroupData(
      id: serializer.fromJson<String>(json['id']),
      classId: serializer.fromJson<String>(json['classId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'classId': serializer.toJson<String>(classId),
    };
  }

  ClassGroupData copyWith({String? id, String? classId}) =>
      ClassGroupData(id: id ?? this.id, classId: classId ?? this.classId);
  ClassGroupData copyWithCompanion(ClassGroupCompanion data) {
    return ClassGroupData(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroupData(')
          ..write('id: $id, ')
          ..write('classId: $classId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassGroupData &&
          other.id == this.id &&
          other.classId == this.classId);
}

class ClassGroupCompanion extends UpdateCompanion<ClassGroupData> {
  final Value<String> id;
  final Value<String> classId;
  final Value<int> rowid;
  const ClassGroupCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassGroupCompanion.insert({
    required String id,
    required String classId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       classId = Value(classId);
  static Insertable<ClassGroupData> custom({
    Expression<String>? id,
    Expression<String>? classId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassGroupCompanion copyWith({
    Value<String>? id,
    Value<String>? classId,
    Value<int>? rowid,
  }) {
    return ClassGroupCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroupCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassMeetingsTable extends ClassMeetings
    with TableInfo<$ClassMeetingsTable, ClassMeeting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassMeetingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES university_class (id)',
    ),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classId,
    startTime,
    endTime,
    lastChecked,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_meetings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassMeeting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClassMeeting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassMeeting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
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
    );
  }

  @override
  $ClassMeetingsTable createAlias(String alias) {
    return $ClassMeetingsTable(attachedDatabase, alias);
  }
}

class ClassMeeting extends DataClass implements Insertable<ClassMeeting> {
  final int id;
  final String classId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime lastChecked;
  const ClassMeeting({
    required this.id,
    required this.classId,
    required this.startTime,
    required this.endTime,
    required this.lastChecked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_id'] = Variable<String>(classId);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['last_checked'] = Variable<DateTime>(lastChecked);
    return map;
  }

  ClassMeetingsCompanion toCompanion(bool nullToAbsent) {
    return ClassMeetingsCompanion(
      id: Value(id),
      classId: Value(classId),
      startTime: Value(startTime),
      endTime: Value(endTime),
      lastChecked: Value(lastChecked),
    );
  }

  factory ClassMeeting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassMeeting(
      id: serializer.fromJson<int>(json['id']),
      classId: serializer.fromJson<String>(json['classId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      lastChecked: serializer.fromJson<DateTime>(json['lastChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classId': serializer.toJson<String>(classId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'lastChecked': serializer.toJson<DateTime>(lastChecked),
    };
  }

  ClassMeeting copyWith({
    int? id,
    String? classId,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? lastChecked,
  }) => ClassMeeting(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    lastChecked: lastChecked ?? this.lastChecked,
  );
  ClassMeeting copyWithCompanion(ClassMeetingsCompanion data) {
    return ClassMeeting(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      lastChecked: data.lastChecked.present
          ? data.lastChecked.value
          : this.lastChecked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassMeeting(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lastChecked: $lastChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classId, startTime, endTime, lastChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassMeeting &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.lastChecked == this.lastChecked);
}

class ClassMeetingsCompanion extends UpdateCompanion<ClassMeeting> {
  final Value<int> id;
  final Value<String> classId;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<DateTime> lastChecked;
  const ClassMeetingsCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.lastChecked = const Value.absent(),
  });
  ClassMeetingsCompanion.insert({
    this.id = const Value.absent(),
    required String classId,
    required DateTime startTime,
    required DateTime endTime,
    this.lastChecked = const Value.absent(),
  }) : classId = Value(classId),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<ClassMeeting> custom({
    Expression<int>? id,
    Expression<String>? classId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<DateTime>? lastChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (lastChecked != null) 'last_checked': lastChecked,
    });
  }

  ClassMeetingsCompanion copyWith({
    Value<int>? id,
    Value<String>? classId,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<DateTime>? lastChecked,
  }) {
    return ClassMeetingsCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassMeetingsCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lastChecked: $lastChecked')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeacherTable teacher = $TeacherTable(this);
  late final $UniversityClassTable universityClass = $UniversityClassTable(
    this,
  );
  late final $ClassGroupTable classGroup = $ClassGroupTable(this);
  late final $ClassMeetingsTable classMeetings = $ClassMeetingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teacher,
    universityClass,
    classGroup,
    classMeetings,
  ];
}

typedef $$TeacherTableCreateCompanionBuilder =
    TeacherCompanion Function({Value<int> id, required String name});
typedef $$TeacherTableUpdateCompanionBuilder =
    TeacherCompanion Function({Value<int> id, Value<String> name});

final class $$TeacherTableReferences
    extends BaseReferences<_$AppDatabase, $TeacherTable, TeacherData> {
  $$TeacherTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UniversityClassTable, List<UniversityClassData>>
  _universityClassRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.universityClass,
    aliasName: $_aliasNameGenerator(
      db.teacher.id,
      db.universityClass.teacherId,
    ),
  );

  $$UniversityClassTableProcessedTableManager get universityClassRefs {
    final manager = $$UniversityClassTableTableManager(
      $_db,
      $_db.universityClass,
    ).filter((f) => f.teacherId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _universityClassRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  Expression<bool> universityClassRefs(
    Expression<bool> Function($$UniversityClassTableFilterComposer f) f,
  ) {
    final $$UniversityClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.teacherId,
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
    return f(composer);
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

  Expression<T> universityClassRefs<T extends Object>(
    Expression<T> Function($$UniversityClassTableAnnotationComposer a) f,
  ) {
    final $$UniversityClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.universityClass,
      getReferencedColumn: (t) => t.teacherId,
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
    return f(composer);
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
          PrefetchHooks Function({bool universityClassRefs})
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
          prefetchHooksCallback: ({universityClassRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (universityClassRefs) db.universityClass,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (universityClassRefs)
                    await $_getPrefetchedData<
                      TeacherData,
                      $TeacherTable,
                      UniversityClassData
                    >(
                      currentTable: table,
                      referencedTable: $$TeacherTableReferences
                          ._universityClassRefsTable(db),
                      managerFromTypedResult: (p0) => $$TeacherTableReferences(
                        db,
                        table,
                        p0,
                      ).universityClassRefs,
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
      PrefetchHooks Function({bool universityClassRefs})
    >;
typedef $$UniversityClassTableCreateCompanionBuilder =
    UniversityClassCompanion Function({
      required String id,
      required String name,
      required String code,
      required ClassKind kind,
      Value<String?> room,
      Value<int?> teacherId,
      Value<int> rowid,
    });
typedef $$UniversityClassTableUpdateCompanionBuilder =
    UniversityClassCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<ClassKind> kind,
      Value<String?> room,
      Value<int?> teacherId,
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

  static $TeacherTable _teacherIdTable(_$AppDatabase db) =>
      db.teacher.createAlias(
        $_aliasNameGenerator(db.universityClass.teacherId, db.teacher.id),
      );

  $$TeacherTableProcessedTableManager? get teacherId {
    final $_column = $_itemColumn<int>('teacher_id');
    if ($_column == null) return null;
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

  static MultiTypedResultKey<$ClassGroupTable, List<ClassGroupData>>
  _classGroupRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.classGroup,
    aliasName: $_aliasNameGenerator(
      db.universityClass.id,
      db.classGroup.classId,
    ),
  );

  $$ClassGroupTableProcessedTableManager get classGroupRefs {
    final manager = $$ClassGroupTableTableManager(
      $_db,
      $_db.classGroup,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_classGroupRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ClassMeetingsTable, List<ClassMeeting>>
  _classMeetingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.classMeetings,
    aliasName: $_aliasNameGenerator(
      db.universityClass.id,
      db.classMeetings.classId,
    ),
  );

  $$ClassMeetingsTableProcessedTableManager get classMeetingsRefs {
    final manager = $$ClassMeetingsTableTableManager(
      $_db,
      $_db.classMeetings,
    ).filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_classMeetingsRefsTable($_db));
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

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );

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

  Expression<bool> classGroupRefs(
    Expression<bool> Function($$ClassGroupTableFilterComposer f) f,
  ) {
    final $$ClassGroupTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.classId,
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

  Expression<bool> classMeetingsRefs(
    Expression<bool> Function($$ClassMeetingsTableFilterComposer f) f,
  ) {
    final $$ClassMeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classMeetings,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassMeetingsTableFilterComposer(
            $db: $db,
            $table: $db.classMeetings,
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

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );

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

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

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

  Expression<T> classGroupRefs<T extends Object>(
    Expression<T> Function($$ClassGroupTableAnnotationComposer a) f,
  ) {
    final $$ClassGroupTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classGroup,
      getReferencedColumn: (t) => t.classId,
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

  Expression<T> classMeetingsRefs<T extends Object>(
    Expression<T> Function($$ClassMeetingsTableAnnotationComposer a) f,
  ) {
    final $$ClassMeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.classMeetings,
      getReferencedColumn: (t) => t.classId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClassMeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.classMeetings,
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
          PrefetchHooks Function({
            bool teacherId,
            bool classGroupRefs,
            bool classMeetingsRefs,
          })
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
                Value<String?> room = const Value.absent(),
                Value<int?> teacherId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversityClassCompanion(
                id: id,
                name: name,
                code: code,
                kind: kind,
                room: room,
                teacherId: teacherId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String code,
                required ClassKind kind,
                Value<String?> room = const Value.absent(),
                Value<int?> teacherId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversityClassCompanion.insert(
                id: id,
                name: name,
                code: code,
                kind: kind,
                room: room,
                teacherId: teacherId,
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
          prefetchHooksCallback:
              ({
                teacherId = false,
                classGroupRefs = false,
                classMeetingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (classGroupRefs) db.classGroup,
                    if (classMeetingsRefs) db.classMeetings,
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
                        if (teacherId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.teacherId,
                                    referencedTable:
                                        $$UniversityClassTableReferences
                                            ._teacherIdTable(db),
                                    referencedColumn:
                                        $$UniversityClassTableReferences
                                            ._teacherIdTable(db)
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
                          UniversityClassData,
                          $UniversityClassTable,
                          ClassGroupData
                        >(
                          currentTable: table,
                          referencedTable: $$UniversityClassTableReferences
                              ._classGroupRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UniversityClassTableReferences(
                                db,
                                table,
                                p0,
                              ).classGroupRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.classId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (classMeetingsRefs)
                        await $_getPrefetchedData<
                          UniversityClassData,
                          $UniversityClassTable,
                          ClassMeeting
                        >(
                          currentTable: table,
                          referencedTable: $$UniversityClassTableReferences
                              ._classMeetingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UniversityClassTableReferences(
                                db,
                                table,
                                p0,
                              ).classMeetingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.classId == item.id,
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
      PrefetchHooks Function({
        bool teacherId,
        bool classGroupRefs,
        bool classMeetingsRefs,
      })
    >;
typedef $$ClassGroupTableCreateCompanionBuilder =
    ClassGroupCompanion Function({
      required String id,
      required String classId,
      Value<int> rowid,
    });
typedef $$ClassGroupTableUpdateCompanionBuilder =
    ClassGroupCompanion Function({
      Value<String> id,
      Value<String> classId,
      Value<int> rowid,
    });

final class $$ClassGroupTableReferences
    extends BaseReferences<_$AppDatabase, $ClassGroupTable, ClassGroupData> {
  $$ClassGroupTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UniversityClassTable _classIdTable(_$AppDatabase db) =>
      db.universityClass.createAlias(
        $_aliasNameGenerator(db.classGroup.classId, db.universityClass.id),
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

class $$ClassGroupTableFilterComposer
    extends Composer<_$AppDatabase, $ClassGroupTable> {
  $$ClassGroupTableFilterComposer({
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

class $$ClassGroupTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassGroupTable> {
  $$ClassGroupTableOrderingComposer({
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

class $$ClassGroupTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassGroupTable> {
  $$ClassGroupTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

class $$ClassGroupTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassGroupTable,
          ClassGroupData,
          $$ClassGroupTableFilterComposer,
          $$ClassGroupTableOrderingComposer,
          $$ClassGroupTableAnnotationComposer,
          $$ClassGroupTableCreateCompanionBuilder,
          $$ClassGroupTableUpdateCompanionBuilder,
          (ClassGroupData, $$ClassGroupTableReferences),
          ClassGroupData,
          PrefetchHooks Function({bool classId})
        > {
  $$ClassGroupTableTableManager(_$AppDatabase db, $ClassGroupTable table)
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
                Value<String> id = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassGroupCompanion(id: id, classId: classId, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String classId,
                Value<int> rowid = const Value.absent(),
              }) => ClassGroupCompanion.insert(
                id: id,
                classId: classId,
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
                                referencedTable: $$ClassGroupTableReferences
                                    ._classIdTable(db),
                                referencedColumn: $$ClassGroupTableReferences
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

typedef $$ClassGroupTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassGroupTable,
      ClassGroupData,
      $$ClassGroupTableFilterComposer,
      $$ClassGroupTableOrderingComposer,
      $$ClassGroupTableAnnotationComposer,
      $$ClassGroupTableCreateCompanionBuilder,
      $$ClassGroupTableUpdateCompanionBuilder,
      (ClassGroupData, $$ClassGroupTableReferences),
      ClassGroupData,
      PrefetchHooks Function({bool classId})
    >;
typedef $$ClassMeetingsTableCreateCompanionBuilder =
    ClassMeetingsCompanion Function({
      Value<int> id,
      required String classId,
      required DateTime startTime,
      required DateTime endTime,
      Value<DateTime> lastChecked,
    });
typedef $$ClassMeetingsTableUpdateCompanionBuilder =
    ClassMeetingsCompanion Function({
      Value<int> id,
      Value<String> classId,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<DateTime> lastChecked,
    });

final class $$ClassMeetingsTableReferences
    extends BaseReferences<_$AppDatabase, $ClassMeetingsTable, ClassMeeting> {
  $$ClassMeetingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UniversityClassTable _classIdTable(_$AppDatabase db) =>
      db.universityClass.createAlias(
        $_aliasNameGenerator(db.classMeetings.classId, db.universityClass.id),
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

class $$ClassMeetingsTableFilterComposer
    extends Composer<_$AppDatabase, $ClassMeetingsTable> {
  $$ClassMeetingsTableFilterComposer({
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

class $$ClassMeetingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassMeetingsTable> {
  $$ClassMeetingsTableOrderingComposer({
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

class $$ClassMeetingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassMeetingsTable> {
  $$ClassMeetingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get lastChecked => $composableBuilder(
    column: $table.lastChecked,
    builder: (column) => column,
  );

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

class $$ClassMeetingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassMeetingsTable,
          ClassMeeting,
          $$ClassMeetingsTableFilterComposer,
          $$ClassMeetingsTableOrderingComposer,
          $$ClassMeetingsTableAnnotationComposer,
          $$ClassMeetingsTableCreateCompanionBuilder,
          $$ClassMeetingsTableUpdateCompanionBuilder,
          (ClassMeeting, $$ClassMeetingsTableReferences),
          ClassMeeting,
          PrefetchHooks Function({bool classId})
        > {
  $$ClassMeetingsTableTableManager(_$AppDatabase db, $ClassMeetingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassMeetingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassMeetingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassMeetingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<DateTime> lastChecked = const Value.absent(),
              }) => ClassMeetingsCompanion(
                id: id,
                classId: classId,
                startTime: startTime,
                endTime: endTime,
                lastChecked: lastChecked,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String classId,
                required DateTime startTime,
                required DateTime endTime,
                Value<DateTime> lastChecked = const Value.absent(),
              }) => ClassMeetingsCompanion.insert(
                id: id,
                classId: classId,
                startTime: startTime,
                endTime: endTime,
                lastChecked: lastChecked,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClassMeetingsTableReferences(db, table, e),
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
                                referencedTable: $$ClassMeetingsTableReferences
                                    ._classIdTable(db),
                                referencedColumn: $$ClassMeetingsTableReferences
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

typedef $$ClassMeetingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassMeetingsTable,
      ClassMeeting,
      $$ClassMeetingsTableFilterComposer,
      $$ClassMeetingsTableOrderingComposer,
      $$ClassMeetingsTableAnnotationComposer,
      $$ClassMeetingsTableCreateCompanionBuilder,
      $$ClassMeetingsTableUpdateCompanionBuilder,
      (ClassMeeting, $$ClassMeetingsTableReferences),
      ClassMeeting,
      PrefetchHooks Function({bool classId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeacherTableTableManager get teacher =>
      $$TeacherTableTableManager(_db, _db.teacher);
  $$UniversityClassTableTableManager get universityClass =>
      $$UniversityClassTableTableManager(_db, _db.universityClass);
  $$ClassGroupTableTableManager get classGroup =>
      $$ClassGroupTableTableManager(_db, _db.classGroup);
  $$ClassMeetingsTableTableManager get classMeetings =>
      $$ClassMeetingsTableTableManager(_db, _db.classMeetings);
}
