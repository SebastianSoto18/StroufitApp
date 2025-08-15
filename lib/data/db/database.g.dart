// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [categoryId, name, createdAt, deletedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int categoryId;
  final String name;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  const Category(
      {required this.categoryId,
      required this.name,
      required this.createdAt,
      this.deletedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      categoryId: Value(categoryId),
      name: Value(name),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isActive: Value(isActive),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Category copyWith(
          {int? categoryId,
          String? name,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive}) =>
      Category(
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(categoryId, name, createdAt, deletedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> categoryId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  const CategoriesCompanion({
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.categoryId = const Value.absent(),
    required String name,
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Category> custom({
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? categoryId,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive}) {
    return CategoriesCompanion(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $GarmentsTable extends Garments with TableInfo<$GarmentsTable, Garment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GarmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _garmentIdMeta =
      const VerificationMeta('garmentId');
  @override
  late final GeneratedColumn<int> garmentId = GeneratedColumn<int>(
      'garment_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [garmentId, imagePath, createdAt, deletedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garments';
  @override
  VerificationContext validateIntegrity(Insertable<Garment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('garment_id')) {
      context.handle(_garmentIdMeta,
          garmentId.isAcceptableOrUnknown(data['garment_id']!, _garmentIdMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {garmentId};
  @override
  Garment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Garment(
      garmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}garment_id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GarmentsTable createAlias(String alias) {
    return $GarmentsTable(attachedDatabase, alias);
  }
}

class Garment extends DataClass implements Insertable<Garment> {
  final int garmentId;
  final String imagePath;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  const Garment(
      {required this.garmentId,
      required this.imagePath,
      required this.createdAt,
      this.deletedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['garment_id'] = Variable<int>(garmentId);
    map['image_path'] = Variable<String>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GarmentsCompanion toCompanion(bool nullToAbsent) {
    return GarmentsCompanion(
      garmentId: Value(garmentId),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isActive: Value(isActive),
    );
  }

  factory Garment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Garment(
      garmentId: serializer.fromJson<int>(json['garmentId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'garmentId': serializer.toJson<int>(garmentId),
      'imagePath': serializer.toJson<String>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Garment copyWith(
          {int? garmentId,
          String? imagePath,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive}) =>
      Garment(
        garmentId: garmentId ?? this.garmentId,
        imagePath: imagePath ?? this.imagePath,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
      );
  Garment copyWithCompanion(GarmentsCompanion data) {
    return Garment(
      garmentId: data.garmentId.present ? data.garmentId.value : this.garmentId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Garment(')
          ..write('garmentId: $garmentId, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(garmentId, imagePath, createdAt, deletedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garment &&
          other.garmentId == this.garmentId &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive);
}

class GarmentsCompanion extends UpdateCompanion<Garment> {
  final Value<int> garmentId;
  final Value<String> imagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  const GarmentsCompanion({
    this.garmentId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  GarmentsCompanion.insert({
    this.garmentId = const Value.absent(),
    required String imagePath,
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : imagePath = Value(imagePath),
        createdAt = Value(createdAt);
  static Insertable<Garment> custom({
    Expression<int>? garmentId,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (garmentId != null) 'garment_id': garmentId,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  GarmentsCompanion copyWith(
      {Value<int>? garmentId,
      Value<String>? imagePath,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive}) {
    return GarmentsCompanion(
      garmentId: garmentId ?? this.garmentId,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (garmentId.present) {
      map['garment_id'] = Variable<int>(garmentId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GarmentsCompanion(')
          ..write('garmentId: $garmentId, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $GarmentCategoriesTable extends GarmentCategories
    with TableInfo<$GarmentCategoriesTable, GarmentCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GarmentCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _garmentCategoriesIdMeta =
      const VerificationMeta('garmentCategoriesId');
  @override
  late final GeneratedColumn<int> garmentCategoriesId = GeneratedColumn<int>(
      'garment_categories_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (category_id)'));
  static const VerificationMeta _garmentIdMeta =
      const VerificationMeta('garmentId');
  @override
  late final GeneratedColumn<int> garmentId = GeneratedColumn<int>(
      'garment_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES garments (garment_id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        garmentCategoriesId,
        categoryId,
        garmentId,
        createdAt,
        deletedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garment_categories';
  @override
  VerificationContext validateIntegrity(Insertable<GarmentCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('garment_categories_id')) {
      context.handle(
          _garmentCategoriesIdMeta,
          garmentCategoriesId.isAcceptableOrUnknown(
              data['garment_categories_id']!, _garmentCategoriesIdMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('garment_id')) {
      context.handle(_garmentIdMeta,
          garmentId.isAcceptableOrUnknown(data['garment_id']!, _garmentIdMeta));
    } else if (isInserting) {
      context.missing(_garmentIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {garmentCategoriesId};
  @override
  GarmentCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GarmentCategory(
      garmentCategoriesId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}garment_categories_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      garmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}garment_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GarmentCategoriesTable createAlias(String alias) {
    return $GarmentCategoriesTable(attachedDatabase, alias);
  }
}

class GarmentCategory extends DataClass implements Insertable<GarmentCategory> {
  final int garmentCategoriesId;
  final int categoryId;
  final int garmentId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  const GarmentCategory(
      {required this.garmentCategoriesId,
      required this.categoryId,
      required this.garmentId,
      required this.createdAt,
      this.deletedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['garment_categories_id'] = Variable<int>(garmentCategoriesId);
    map['category_id'] = Variable<int>(categoryId);
    map['garment_id'] = Variable<int>(garmentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GarmentCategoriesCompanion toCompanion(bool nullToAbsent) {
    return GarmentCategoriesCompanion(
      garmentCategoriesId: Value(garmentCategoriesId),
      categoryId: Value(categoryId),
      garmentId: Value(garmentId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isActive: Value(isActive),
    );
  }

  factory GarmentCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GarmentCategory(
      garmentCategoriesId:
          serializer.fromJson<int>(json['garmentCategoriesId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      garmentId: serializer.fromJson<int>(json['garmentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'garmentCategoriesId': serializer.toJson<int>(garmentCategoriesId),
      'categoryId': serializer.toJson<int>(categoryId),
      'garmentId': serializer.toJson<int>(garmentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GarmentCategory copyWith(
          {int? garmentCategoriesId,
          int? categoryId,
          int? garmentId,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive}) =>
      GarmentCategory(
        garmentCategoriesId: garmentCategoriesId ?? this.garmentCategoriesId,
        categoryId: categoryId ?? this.categoryId,
        garmentId: garmentId ?? this.garmentId,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
      );
  GarmentCategory copyWithCompanion(GarmentCategoriesCompanion data) {
    return GarmentCategory(
      garmentCategoriesId: data.garmentCategoriesId.present
          ? data.garmentCategoriesId.value
          : this.garmentCategoriesId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      garmentId: data.garmentId.present ? data.garmentId.value : this.garmentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GarmentCategory(')
          ..write('garmentCategoriesId: $garmentCategoriesId, ')
          ..write('categoryId: $categoryId, ')
          ..write('garmentId: $garmentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(garmentCategoriesId, categoryId, garmentId,
      createdAt, deletedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GarmentCategory &&
          other.garmentCategoriesId == this.garmentCategoriesId &&
          other.categoryId == this.categoryId &&
          other.garmentId == this.garmentId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive);
}

class GarmentCategoriesCompanion extends UpdateCompanion<GarmentCategory> {
  final Value<int> garmentCategoriesId;
  final Value<int> categoryId;
  final Value<int> garmentId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  const GarmentCategoriesCompanion({
    this.garmentCategoriesId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.garmentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  GarmentCategoriesCompanion.insert({
    this.garmentCategoriesId = const Value.absent(),
    required int categoryId,
    required int garmentId,
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : categoryId = Value(categoryId),
        garmentId = Value(garmentId),
        createdAt = Value(createdAt);
  static Insertable<GarmentCategory> custom({
    Expression<int>? garmentCategoriesId,
    Expression<int>? categoryId,
    Expression<int>? garmentId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (garmentCategoriesId != null)
        'garment_categories_id': garmentCategoriesId,
      if (categoryId != null) 'category_id': categoryId,
      if (garmentId != null) 'garment_id': garmentId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  GarmentCategoriesCompanion copyWith(
      {Value<int>? garmentCategoriesId,
      Value<int>? categoryId,
      Value<int>? garmentId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive}) {
    return GarmentCategoriesCompanion(
      garmentCategoriesId: garmentCategoriesId ?? this.garmentCategoriesId,
      categoryId: categoryId ?? this.categoryId,
      garmentId: garmentId ?? this.garmentId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (garmentCategoriesId.present) {
      map['garment_categories_id'] = Variable<int>(garmentCategoriesId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (garmentId.present) {
      map['garment_id'] = Variable<int>(garmentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GarmentCategoriesCompanion(')
          ..write('garmentCategoriesId: $garmentCategoriesId, ')
          ..write('categoryId: $categoryId, ')
          ..write('garmentId: $garmentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $GarmentsTable garments = $GarmentsTable(this);
  late final $GarmentCategoriesTable garmentCategories =
      $GarmentCategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, garments, garmentCategories];
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> categoryId,
  required String name,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> categoryId,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GarmentCategoriesTable, List<GarmentCategory>>
      _garmentCategoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.garmentCategories,
              aliasName: $_aliasNameGenerator(
                  db.categories.categoryId, db.garmentCategories.categoryId));

  $$GarmentCategoriesTableProcessedTableManager get garmentCategoriesRefs {
    final manager =
        $$GarmentCategoriesTableTableManager($_db, $_db.garmentCategories)
            .filter((f) => f.categoryId.categoryId
                .sqlEquals($_itemColumn<int>('category_id')!));

    final cache =
        $_typedResult.readTableOrNull(_garmentCategoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> garmentCategoriesRefs(
      Expression<bool> Function($$GarmentCategoriesTableFilterComposer f) f) {
    final $$GarmentCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.garmentCategories,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GarmentCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.garmentCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> garmentCategoriesRefs<T extends Object>(
      Expression<T> Function($$GarmentCategoriesTableAnnotationComposer a) f) {
    final $$GarmentCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.garmentCategories,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GarmentCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.garmentCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool garmentCategoriesRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> categoryId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              CategoriesCompanion(
            categoryId: categoryId,
            name: name,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> categoryId = const Value.absent(),
            required String name,
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            categoryId: categoryId,
            name: name,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({garmentCategoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (garmentCategoriesRefs) db.garmentCategories
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (garmentCategoriesRefs)
                    await $_getPrefetchedData<Category, $CategoriesTable,
                            GarmentCategory>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableReferences
                            ._garmentCategoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .garmentCategoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.categoryId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool garmentCategoriesRefs})>;
typedef $$GarmentsTableCreateCompanionBuilder = GarmentsCompanion Function({
  Value<int> garmentId,
  required String imagePath,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});
typedef $$GarmentsTableUpdateCompanionBuilder = GarmentsCompanion Function({
  Value<int> garmentId,
  Value<String> imagePath,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});

final class $$GarmentsTableReferences
    extends BaseReferences<_$AppDatabase, $GarmentsTable, Garment> {
  $$GarmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GarmentCategoriesTable, List<GarmentCategory>>
      _garmentCategoriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.garmentCategories,
              aliasName: $_aliasNameGenerator(
                  db.garments.garmentId, db.garmentCategories.garmentId));

  $$GarmentCategoriesTableProcessedTableManager get garmentCategoriesRefs {
    final manager = $$GarmentCategoriesTableTableManager(
            $_db, $_db.garmentCategories)
        .filter((f) =>
            f.garmentId.garmentId.sqlEquals($_itemColumn<int>('garment_id')!));

    final cache =
        $_typedResult.readTableOrNull(_garmentCategoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GarmentsTableFilterComposer
    extends Composer<_$AppDatabase, $GarmentsTable> {
  $$GarmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get garmentId => $composableBuilder(
      column: $table.garmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> garmentCategoriesRefs(
      Expression<bool> Function($$GarmentCategoriesTableFilterComposer f) f) {
    final $$GarmentCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.garmentId,
        referencedTable: $db.garmentCategories,
        getReferencedColumn: (t) => t.garmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GarmentCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.garmentCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GarmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $GarmentsTable> {
  $$GarmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get garmentId => $composableBuilder(
      column: $table.garmentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$GarmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GarmentsTable> {
  $$GarmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get garmentId =>
      $composableBuilder(column: $table.garmentId, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> garmentCategoriesRefs<T extends Object>(
      Expression<T> Function($$GarmentCategoriesTableAnnotationComposer a) f) {
    final $$GarmentCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.garmentId,
            referencedTable: $db.garmentCategories,
            getReferencedColumn: (t) => t.garmentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GarmentCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.garmentCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$GarmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GarmentsTable,
    Garment,
    $$GarmentsTableFilterComposer,
    $$GarmentsTableOrderingComposer,
    $$GarmentsTableAnnotationComposer,
    $$GarmentsTableCreateCompanionBuilder,
    $$GarmentsTableUpdateCompanionBuilder,
    (Garment, $$GarmentsTableReferences),
    Garment,
    PrefetchHooks Function({bool garmentCategoriesRefs})> {
  $$GarmentsTableTableManager(_$AppDatabase db, $GarmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GarmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GarmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GarmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> garmentId = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              GarmentsCompanion(
            garmentId: garmentId,
            imagePath: imagePath,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> garmentId = const Value.absent(),
            required String imagePath,
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              GarmentsCompanion.insert(
            garmentId: garmentId,
            imagePath: imagePath,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GarmentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({garmentCategoriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (garmentCategoriesRefs) db.garmentCategories
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (garmentCategoriesRefs)
                    await $_getPrefetchedData<Garment, $GarmentsTable,
                            GarmentCategory>(
                        currentTable: table,
                        referencedTable: $$GarmentsTableReferences
                            ._garmentCategoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GarmentsTableReferences(db, table, p0)
                                .garmentCategoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.garmentId == item.garmentId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GarmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GarmentsTable,
    Garment,
    $$GarmentsTableFilterComposer,
    $$GarmentsTableOrderingComposer,
    $$GarmentsTableAnnotationComposer,
    $$GarmentsTableCreateCompanionBuilder,
    $$GarmentsTableUpdateCompanionBuilder,
    (Garment, $$GarmentsTableReferences),
    Garment,
    PrefetchHooks Function({bool garmentCategoriesRefs})>;
typedef $$GarmentCategoriesTableCreateCompanionBuilder
    = GarmentCategoriesCompanion Function({
  Value<int> garmentCategoriesId,
  required int categoryId,
  required int garmentId,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});
typedef $$GarmentCategoriesTableUpdateCompanionBuilder
    = GarmentCategoriesCompanion Function({
  Value<int> garmentCategoriesId,
  Value<int> categoryId,
  Value<int> garmentId,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});

final class $$GarmentCategoriesTableReferences extends BaseReferences<
    _$AppDatabase, $GarmentCategoriesTable, GarmentCategory> {
  $$GarmentCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias($_aliasNameGenerator(
          db.garmentCategories.categoryId, db.categories.categoryId));

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.categoryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GarmentsTable _garmentIdTable(_$AppDatabase db) =>
      db.garments.createAlias($_aliasNameGenerator(
          db.garmentCategories.garmentId, db.garments.garmentId));

  $$GarmentsTableProcessedTableManager get garmentId {
    final $_column = $_itemColumn<int>('garment_id')!;

    final manager = $$GarmentsTableTableManager($_db, $_db.garments)
        .filter((f) => f.garmentId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_garmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GarmentCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $GarmentCategoriesTable> {
  $$GarmentCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get garmentCategoriesId => $composableBuilder(
      column: $table.garmentCategoriesId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GarmentsTableFilterComposer get garmentId {
    final $$GarmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.garmentId,
        referencedTable: $db.garments,
        getReferencedColumn: (t) => t.garmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GarmentsTableFilterComposer(
              $db: $db,
              $table: $db.garments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GarmentCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GarmentCategoriesTable> {
  $$GarmentCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get garmentCategoriesId => $composableBuilder(
      column: $table.garmentCategoriesId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GarmentsTableOrderingComposer get garmentId {
    final $$GarmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.garmentId,
        referencedTable: $db.garments,
        getReferencedColumn: (t) => t.garmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GarmentsTableOrderingComposer(
              $db: $db,
              $table: $db.garments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GarmentCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GarmentCategoriesTable> {
  $$GarmentCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get garmentCategoriesId => $composableBuilder(
      column: $table.garmentCategoriesId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GarmentsTableAnnotationComposer get garmentId {
    final $$GarmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.garmentId,
        referencedTable: $db.garments,
        getReferencedColumn: (t) => t.garmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GarmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.garments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GarmentCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GarmentCategoriesTable,
    GarmentCategory,
    $$GarmentCategoriesTableFilterComposer,
    $$GarmentCategoriesTableOrderingComposer,
    $$GarmentCategoriesTableAnnotationComposer,
    $$GarmentCategoriesTableCreateCompanionBuilder,
    $$GarmentCategoriesTableUpdateCompanionBuilder,
    (GarmentCategory, $$GarmentCategoriesTableReferences),
    GarmentCategory,
    PrefetchHooks Function({bool categoryId, bool garmentId})> {
  $$GarmentCategoriesTableTableManager(
      _$AppDatabase db, $GarmentCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GarmentCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GarmentCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GarmentCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> garmentCategoriesId = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<int> garmentId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              GarmentCategoriesCompanion(
            garmentCategoriesId: garmentCategoriesId,
            categoryId: categoryId,
            garmentId: garmentId,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> garmentCategoriesId = const Value.absent(),
            required int categoryId,
            required int garmentId,
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              GarmentCategoriesCompanion.insert(
            garmentCategoriesId: garmentCategoriesId,
            categoryId: categoryId,
            garmentId: garmentId,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GarmentCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false, garmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$GarmentCategoriesTableReferences._categoryIdTable(db),
                    referencedColumn: $$GarmentCategoriesTableReferences
                        ._categoryIdTable(db)
                        .categoryId,
                  ) as T;
                }
                if (garmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.garmentId,
                    referencedTable:
                        $$GarmentCategoriesTableReferences._garmentIdTable(db),
                    referencedColumn: $$GarmentCategoriesTableReferences
                        ._garmentIdTable(db)
                        .garmentId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GarmentCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GarmentCategoriesTable,
    GarmentCategory,
    $$GarmentCategoriesTableFilterComposer,
    $$GarmentCategoriesTableOrderingComposer,
    $$GarmentCategoriesTableAnnotationComposer,
    $$GarmentCategoriesTableCreateCompanionBuilder,
    $$GarmentCategoriesTableUpdateCompanionBuilder,
    (GarmentCategory, $$GarmentCategoriesTableReferences),
    GarmentCategory,
    PrefetchHooks Function({bool categoryId, bool garmentId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$GarmentsTableTableManager get garments =>
      $$GarmentsTableTableManager(_db, _db.garments);
  $$GarmentCategoriesTableTableManager get garmentCategories =>
      $$GarmentCategoriesTableTableManager(_db, _db.garmentCategories);
}
