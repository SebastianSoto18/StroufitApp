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
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _scaleMeta = const VerificationMeta('scale');
  @override
  late final GeneratedColumn<double> scale = GeneratedColumn<double>(
      'scale', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _rotationMeta =
      const VerificationMeta('rotation');
  @override
  late final GeneratedColumn<double> rotation = GeneratedColumn<double>(
      'rotation', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [
        categoryId,
        name,
        createdAt,
        deletedAt,
        isActive,
        isFavorite,
        scale,
        positionX,
        positionY,
        rotation
      ];
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
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('scale')) {
      context.handle(
          _scaleMeta, scale.isAcceptableOrUnknown(data['scale']!, _scaleMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('rotation')) {
      context.handle(_rotationMeta,
          rotation.isAcceptableOrUnknown(data['rotation']!, _rotationMeta));
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
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      scale: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}scale'])!,
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      rotation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rotation'])!,
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
  final bool isFavorite;
  final double scale;
  final double positionX;
  final double positionY;
  final double rotation;
  const Category(
      {required this.categoryId,
      required this.name,
      required this.createdAt,
      this.deletedAt,
      required this.isActive,
      required this.isFavorite,
      required this.scale,
      required this.positionX,
      required this.positionY,
      required this.rotation});
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
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['scale'] = Variable<double>(scale);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['rotation'] = Variable<double>(rotation);
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
      isFavorite: Value(isFavorite),
      scale: Value(scale),
      positionX: Value(positionX),
      positionY: Value(positionY),
      rotation: Value(rotation),
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
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      scale: serializer.fromJson<double>(json['scale']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      rotation: serializer.fromJson<double>(json['rotation']),
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
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'scale': serializer.toJson<double>(scale),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'rotation': serializer.toJson<double>(rotation),
    };
  }

  Category copyWith(
          {int? categoryId,
          String? name,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive,
          bool? isFavorite,
          double? scale,
          double? positionX,
          double? positionY,
          double? rotation}) =>
      Category(
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
        isFavorite: isFavorite ?? this.isFavorite,
        scale: scale ?? this.scale,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        rotation: rotation ?? this.rotation,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      scale: data.scale.present ? data.scale.value : this.scale,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      rotation: data.rotation.present ? data.rotation.value : this.rotation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('scale: $scale, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('rotation: $rotation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoryId, name, createdAt, deletedAt,
      isActive, isFavorite, scale, positionX, positionY, rotation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive &&
          other.isFavorite == this.isFavorite &&
          other.scale == this.scale &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.rotation == this.rotation);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> categoryId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  final Value<bool> isFavorite;
  final Value<double> scale;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<double> rotation;
  const CategoriesCompanion({
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.scale = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.rotation = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.categoryId = const Value.absent(),
    required String name,
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.scale = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.rotation = const Value.absent(),
  })  : name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Category> custom({
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
    Expression<bool>? isFavorite,
    Expression<double>? scale,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<double>? rotation,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (scale != null) 'scale': scale,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (rotation != null) 'rotation': rotation,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? categoryId,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive,
      Value<bool>? isFavorite,
      Value<double>? scale,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<double>? rotation}) {
    return CategoriesCompanion(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
      scale: scale ?? this.scale,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      rotation: rotation ?? this.rotation,
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
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (scale.present) {
      map['scale'] = Variable<double>(scale.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (rotation.present) {
      map['rotation'] = Variable<double>(rotation.value);
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
          ..write('isActive: $isActive, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('scale: $scale, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('rotation: $rotation')
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

class $OutfitsTable extends Outfits with TableInfo<$OutfitsTable, Outfit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutfitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _outfitIdMeta =
      const VerificationMeta('outfitId');
  @override
  late final GeneratedColumn<int> outfitId = GeneratedColumn<int>(
      'outfit_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
      [outfitId, name, imagePath, createdAt, deletedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outfits';
  @override
  VerificationContext validateIntegrity(Insertable<Outfit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('outfit_id')) {
      context.handle(_outfitIdMeta,
          outfitId.isAcceptableOrUnknown(data['outfit_id']!, _outfitIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
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
  Set<GeneratedColumn> get $primaryKey => {outfitId};
  @override
  Outfit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Outfit(
      outfitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}outfit_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
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
  $OutfitsTable createAlias(String alias) {
    return $OutfitsTable(attachedDatabase, alias);
  }
}

class Outfit extends DataClass implements Insertable<Outfit> {
  final int outfitId;
  final String? name;
  final String imagePath;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  const Outfit(
      {required this.outfitId,
      this.name,
      required this.imagePath,
      required this.createdAt,
      this.deletedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['outfit_id'] = Variable<int>(outfitId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['image_path'] = Variable<String>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  OutfitsCompanion toCompanion(bool nullToAbsent) {
    return OutfitsCompanion(
      outfitId: Value(outfitId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isActive: Value(isActive),
    );
  }

  factory Outfit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Outfit(
      outfitId: serializer.fromJson<int>(json['outfitId']),
      name: serializer.fromJson<String?>(json['name']),
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
      'outfitId': serializer.toJson<int>(outfitId),
      'name': serializer.toJson<String?>(name),
      'imagePath': serializer.toJson<String>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Outfit copyWith(
          {int? outfitId,
          Value<String?> name = const Value.absent(),
          String? imagePath,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive}) =>
      Outfit(
        outfitId: outfitId ?? this.outfitId,
        name: name.present ? name.value : this.name,
        imagePath: imagePath ?? this.imagePath,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
      );
  Outfit copyWithCompanion(OutfitsCompanion data) {
    return Outfit(
      outfitId: data.outfitId.present ? data.outfitId.value : this.outfitId,
      name: data.name.present ? data.name.value : this.name,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Outfit(')
          ..write('outfitId: $outfitId, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(outfitId, name, imagePath, createdAt, deletedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Outfit &&
          other.outfitId == this.outfitId &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive);
}

class OutfitsCompanion extends UpdateCompanion<Outfit> {
  final Value<int> outfitId;
  final Value<String?> name;
  final Value<String> imagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  const OutfitsCompanion({
    this.outfitId = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  OutfitsCompanion.insert({
    this.outfitId = const Value.absent(),
    this.name = const Value.absent(),
    required String imagePath,
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : imagePath = Value(imagePath),
        createdAt = Value(createdAt);
  static Insertable<Outfit> custom({
    Expression<int>? outfitId,
    Expression<String>? name,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (outfitId != null) 'outfit_id': outfitId,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  OutfitsCompanion copyWith(
      {Value<int>? outfitId,
      Value<String?>? name,
      Value<String>? imagePath,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive}) {
    return OutfitsCompanion(
      outfitId: outfitId ?? this.outfitId,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (outfitId.present) {
      map['outfit_id'] = Variable<int>(outfitId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('OutfitsCompanion(')
          ..write('outfitId: $outfitId, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $OutfitsGarmentsTable extends OutfitsGarments
    with TableInfo<$OutfitsGarmentsTable, OutfitsGarment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutfitsGarmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _outfitGarmentIdMeta =
      const VerificationMeta('outfitGarmentId');
  @override
  late final GeneratedColumn<int> outfitGarmentId = GeneratedColumn<int>(
      'outfit_garment_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _outfitIdMeta =
      const VerificationMeta('outfitId');
  @override
  late final GeneratedColumn<int> outfitId = GeneratedColumn<int>(
      'outfit_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _garmentIdMeta =
      const VerificationMeta('garmentId');
  @override
  late final GeneratedColumn<int> garmentId = GeneratedColumn<int>(
      'garment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scaleMeta = const VerificationMeta('scale');
  @override
  late final GeneratedColumn<double> scale = GeneratedColumn<double>(
      'scale', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _rotationMeta =
      const VerificationMeta('rotation');
  @override
  late final GeneratedColumn<double> rotation = GeneratedColumn<double>(
      'rotation', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
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
        outfitGarmentId,
        outfitId,
        garmentId,
        scale,
        positionX,
        positionY,
        rotation,
        createdAt,
        deletedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outfits_garments';
  @override
  VerificationContext validateIntegrity(Insertable<OutfitsGarment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('outfit_garment_id')) {
      context.handle(
          _outfitGarmentIdMeta,
          outfitGarmentId.isAcceptableOrUnknown(
              data['outfit_garment_id']!, _outfitGarmentIdMeta));
    }
    if (data.containsKey('outfit_id')) {
      context.handle(_outfitIdMeta,
          outfitId.isAcceptableOrUnknown(data['outfit_id']!, _outfitIdMeta));
    } else if (isInserting) {
      context.missing(_outfitIdMeta);
    }
    if (data.containsKey('garment_id')) {
      context.handle(_garmentIdMeta,
          garmentId.isAcceptableOrUnknown(data['garment_id']!, _garmentIdMeta));
    } else if (isInserting) {
      context.missing(_garmentIdMeta);
    }
    if (data.containsKey('scale')) {
      context.handle(
          _scaleMeta, scale.isAcceptableOrUnknown(data['scale']!, _scaleMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('rotation')) {
      context.handle(_rotationMeta,
          rotation.isAcceptableOrUnknown(data['rotation']!, _rotationMeta));
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
  Set<GeneratedColumn> get $primaryKey => {outfitGarmentId};
  @override
  OutfitsGarment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutfitsGarment(
      outfitGarmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}outfit_garment_id'])!,
      outfitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}outfit_id'])!,
      garmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}garment_id'])!,
      scale: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}scale'])!,
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      rotation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rotation'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $OutfitsGarmentsTable createAlias(String alias) {
    return $OutfitsGarmentsTable(attachedDatabase, alias);
  }
}

class OutfitsGarment extends DataClass implements Insertable<OutfitsGarment> {
  final int outfitGarmentId;
  final int outfitId;
  final int garmentId;
  final double scale;
  final double positionX;
  final double positionY;
  final double rotation;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  const OutfitsGarment(
      {required this.outfitGarmentId,
      required this.outfitId,
      required this.garmentId,
      required this.scale,
      required this.positionX,
      required this.positionY,
      required this.rotation,
      required this.createdAt,
      this.deletedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['outfit_garment_id'] = Variable<int>(outfitGarmentId);
    map['outfit_id'] = Variable<int>(outfitId);
    map['garment_id'] = Variable<int>(garmentId);
    map['scale'] = Variable<double>(scale);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['rotation'] = Variable<double>(rotation);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  OutfitsGarmentsCompanion toCompanion(bool nullToAbsent) {
    return OutfitsGarmentsCompanion(
      outfitGarmentId: Value(outfitGarmentId),
      outfitId: Value(outfitId),
      garmentId: Value(garmentId),
      scale: Value(scale),
      positionX: Value(positionX),
      positionY: Value(positionY),
      rotation: Value(rotation),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      isActive: Value(isActive),
    );
  }

  factory OutfitsGarment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutfitsGarment(
      outfitGarmentId: serializer.fromJson<int>(json['outfitGarmentId']),
      outfitId: serializer.fromJson<int>(json['outfitId']),
      garmentId: serializer.fromJson<int>(json['garmentId']),
      scale: serializer.fromJson<double>(json['scale']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      rotation: serializer.fromJson<double>(json['rotation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'outfitGarmentId': serializer.toJson<int>(outfitGarmentId),
      'outfitId': serializer.toJson<int>(outfitId),
      'garmentId': serializer.toJson<int>(garmentId),
      'scale': serializer.toJson<double>(scale),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'rotation': serializer.toJson<double>(rotation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  OutfitsGarment copyWith(
          {int? outfitGarmentId,
          int? outfitId,
          int? garmentId,
          double? scale,
          double? positionX,
          double? positionY,
          double? rotation,
          DateTime? createdAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? isActive}) =>
      OutfitsGarment(
        outfitGarmentId: outfitGarmentId ?? this.outfitGarmentId,
        outfitId: outfitId ?? this.outfitId,
        garmentId: garmentId ?? this.garmentId,
        scale: scale ?? this.scale,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        rotation: rotation ?? this.rotation,
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        isActive: isActive ?? this.isActive,
      );
  OutfitsGarment copyWithCompanion(OutfitsGarmentsCompanion data) {
    return OutfitsGarment(
      outfitGarmentId: data.outfitGarmentId.present
          ? data.outfitGarmentId.value
          : this.outfitGarmentId,
      outfitId: data.outfitId.present ? data.outfitId.value : this.outfitId,
      garmentId: data.garmentId.present ? data.garmentId.value : this.garmentId,
      scale: data.scale.present ? data.scale.value : this.scale,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      rotation: data.rotation.present ? data.rotation.value : this.rotation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutfitsGarment(')
          ..write('outfitGarmentId: $outfitGarmentId, ')
          ..write('outfitId: $outfitId, ')
          ..write('garmentId: $garmentId, ')
          ..write('scale: $scale, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('rotation: $rotation, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(outfitGarmentId, outfitId, garmentId, scale,
      positionX, positionY, rotation, createdAt, deletedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutfitsGarment &&
          other.outfitGarmentId == this.outfitGarmentId &&
          other.outfitId == this.outfitId &&
          other.garmentId == this.garmentId &&
          other.scale == this.scale &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.rotation == this.rotation &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt &&
          other.isActive == this.isActive);
}

class OutfitsGarmentsCompanion extends UpdateCompanion<OutfitsGarment> {
  final Value<int> outfitGarmentId;
  final Value<int> outfitId;
  final Value<int> garmentId;
  final Value<double> scale;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<double> rotation;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> isActive;
  const OutfitsGarmentsCompanion({
    this.outfitGarmentId = const Value.absent(),
    this.outfitId = const Value.absent(),
    this.garmentId = const Value.absent(),
    this.scale = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.rotation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  OutfitsGarmentsCompanion.insert({
    this.outfitGarmentId = const Value.absent(),
    required int outfitId,
    required int garmentId,
    this.scale = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.rotation = const Value.absent(),
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : outfitId = Value(outfitId),
        garmentId = Value(garmentId),
        createdAt = Value(createdAt);
  static Insertable<OutfitsGarment> custom({
    Expression<int>? outfitGarmentId,
    Expression<int>? outfitId,
    Expression<int>? garmentId,
    Expression<double>? scale,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<double>? rotation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (outfitGarmentId != null) 'outfit_garment_id': outfitGarmentId,
      if (outfitId != null) 'outfit_id': outfitId,
      if (garmentId != null) 'garment_id': garmentId,
      if (scale != null) 'scale': scale,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (rotation != null) 'rotation': rotation,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  OutfitsGarmentsCompanion copyWith(
      {Value<int>? outfitGarmentId,
      Value<int>? outfitId,
      Value<int>? garmentId,
      Value<double>? scale,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<double>? rotation,
      Value<DateTime>? createdAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? isActive}) {
    return OutfitsGarmentsCompanion(
      outfitGarmentId: outfitGarmentId ?? this.outfitGarmentId,
      outfitId: outfitId ?? this.outfitId,
      garmentId: garmentId ?? this.garmentId,
      scale: scale ?? this.scale,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      rotation: rotation ?? this.rotation,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (outfitGarmentId.present) {
      map['outfit_garment_id'] = Variable<int>(outfitGarmentId.value);
    }
    if (outfitId.present) {
      map['outfit_id'] = Variable<int>(outfitId.value);
    }
    if (garmentId.present) {
      map['garment_id'] = Variable<int>(garmentId.value);
    }
    if (scale.present) {
      map['scale'] = Variable<double>(scale.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (rotation.present) {
      map['rotation'] = Variable<double>(rotation.value);
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
    return (StringBuffer('OutfitsGarmentsCompanion(')
          ..write('outfitGarmentId: $outfitGarmentId, ')
          ..write('outfitId: $outfitId, ')
          ..write('garmentId: $garmentId, ')
          ..write('scale: $scale, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('rotation: $rotation, ')
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
  late final $OutfitsTable outfits = $OutfitsTable(this);
  late final $OutfitsGarmentsTable outfitsGarments =
      $OutfitsGarmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, garments, garmentCategories, outfits, outfitsGarments];
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> categoryId,
  required String name,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
  Value<bool> isFavorite,
  Value<double> scale,
  Value<double> positionX,
  Value<double> positionY,
  Value<double> rotation,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> categoryId,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
  Value<bool> isFavorite,
  Value<double> scale,
  Value<double> positionX,
  Value<double> positionY,
  Value<double> rotation,
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

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get scale => $composableBuilder(
      column: $table.scale, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rotation => $composableBuilder(
      column: $table.rotation, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get scale => $composableBuilder(
      column: $table.scale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rotation => $composableBuilder(
      column: $table.rotation, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<double> get scale =>
      $composableBuilder(column: $table.scale, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<double> get rotation =>
      $composableBuilder(column: $table.rotation, builder: (column) => column);

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
            Value<bool> isFavorite = const Value.absent(),
            Value<double> scale = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<double> rotation = const Value.absent(),
          }) =>
              CategoriesCompanion(
            categoryId: categoryId,
            name: name,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
            isFavorite: isFavorite,
            scale: scale,
            positionX: positionX,
            positionY: positionY,
            rotation: rotation,
          ),
          createCompanionCallback: ({
            Value<int> categoryId = const Value.absent(),
            required String name,
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<double> scale = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<double> rotation = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            categoryId: categoryId,
            name: name,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
            isFavorite: isFavorite,
            scale: scale,
            positionX: positionX,
            positionY: positionY,
            rotation: rotation,
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
typedef $$OutfitsTableCreateCompanionBuilder = OutfitsCompanion Function({
  Value<int> outfitId,
  Value<String?> name,
  required String imagePath,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});
typedef $$OutfitsTableUpdateCompanionBuilder = OutfitsCompanion Function({
  Value<int> outfitId,
  Value<String?> name,
  Value<String> imagePath,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});

class $$OutfitsTableFilterComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$OutfitsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$OutfitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutfitsTable> {
  $$OutfitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get outfitId =>
      $composableBuilder(column: $table.outfitId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$OutfitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutfitsTable,
    Outfit,
    $$OutfitsTableFilterComposer,
    $$OutfitsTableOrderingComposer,
    $$OutfitsTableAnnotationComposer,
    $$OutfitsTableCreateCompanionBuilder,
    $$OutfitsTableUpdateCompanionBuilder,
    (Outfit, BaseReferences<_$AppDatabase, $OutfitsTable, Outfit>),
    Outfit,
    PrefetchHooks Function()> {
  $$OutfitsTableTableManager(_$AppDatabase db, $OutfitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutfitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutfitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutfitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> outfitId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              OutfitsCompanion(
            outfitId: outfitId,
            name: name,
            imagePath: imagePath,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> outfitId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String imagePath,
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              OutfitsCompanion.insert(
            outfitId: outfitId,
            name: name,
            imagePath: imagePath,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutfitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutfitsTable,
    Outfit,
    $$OutfitsTableFilterComposer,
    $$OutfitsTableOrderingComposer,
    $$OutfitsTableAnnotationComposer,
    $$OutfitsTableCreateCompanionBuilder,
    $$OutfitsTableUpdateCompanionBuilder,
    (Outfit, BaseReferences<_$AppDatabase, $OutfitsTable, Outfit>),
    Outfit,
    PrefetchHooks Function()>;
typedef $$OutfitsGarmentsTableCreateCompanionBuilder = OutfitsGarmentsCompanion
    Function({
  Value<int> outfitGarmentId,
  required int outfitId,
  required int garmentId,
  Value<double> scale,
  Value<double> positionX,
  Value<double> positionY,
  Value<double> rotation,
  required DateTime createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});
typedef $$OutfitsGarmentsTableUpdateCompanionBuilder = OutfitsGarmentsCompanion
    Function({
  Value<int> outfitGarmentId,
  Value<int> outfitId,
  Value<int> garmentId,
  Value<double> scale,
  Value<double> positionX,
  Value<double> positionY,
  Value<double> rotation,
  Value<DateTime> createdAt,
  Value<DateTime?> deletedAt,
  Value<bool> isActive,
});

class $$OutfitsGarmentsTableFilterComposer
    extends Composer<_$AppDatabase, $OutfitsGarmentsTable> {
  $$OutfitsGarmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get outfitGarmentId => $composableBuilder(
      column: $table.outfitGarmentId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get garmentId => $composableBuilder(
      column: $table.garmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get scale => $composableBuilder(
      column: $table.scale, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rotation => $composableBuilder(
      column: $table.rotation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$OutfitsGarmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutfitsGarmentsTable> {
  $$OutfitsGarmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get outfitGarmentId => $composableBuilder(
      column: $table.outfitGarmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get outfitId => $composableBuilder(
      column: $table.outfitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get garmentId => $composableBuilder(
      column: $table.garmentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get scale => $composableBuilder(
      column: $table.scale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rotation => $composableBuilder(
      column: $table.rotation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$OutfitsGarmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutfitsGarmentsTable> {
  $$OutfitsGarmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get outfitGarmentId => $composableBuilder(
      column: $table.outfitGarmentId, builder: (column) => column);

  GeneratedColumn<int> get outfitId =>
      $composableBuilder(column: $table.outfitId, builder: (column) => column);

  GeneratedColumn<int> get garmentId =>
      $composableBuilder(column: $table.garmentId, builder: (column) => column);

  GeneratedColumn<double> get scale =>
      $composableBuilder(column: $table.scale, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<double> get rotation =>
      $composableBuilder(column: $table.rotation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$OutfitsGarmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutfitsGarmentsTable,
    OutfitsGarment,
    $$OutfitsGarmentsTableFilterComposer,
    $$OutfitsGarmentsTableOrderingComposer,
    $$OutfitsGarmentsTableAnnotationComposer,
    $$OutfitsGarmentsTableCreateCompanionBuilder,
    $$OutfitsGarmentsTableUpdateCompanionBuilder,
    (
      OutfitsGarment,
      BaseReferences<_$AppDatabase, $OutfitsGarmentsTable, OutfitsGarment>
    ),
    OutfitsGarment,
    PrefetchHooks Function()> {
  $$OutfitsGarmentsTableTableManager(
      _$AppDatabase db, $OutfitsGarmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutfitsGarmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutfitsGarmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutfitsGarmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> outfitGarmentId = const Value.absent(),
            Value<int> outfitId = const Value.absent(),
            Value<int> garmentId = const Value.absent(),
            Value<double> scale = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<double> rotation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              OutfitsGarmentsCompanion(
            outfitGarmentId: outfitGarmentId,
            outfitId: outfitId,
            garmentId: garmentId,
            scale: scale,
            positionX: positionX,
            positionY: positionY,
            rotation: rotation,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> outfitGarmentId = const Value.absent(),
            required int outfitId,
            required int garmentId,
            Value<double> scale = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<double> rotation = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              OutfitsGarmentsCompanion.insert(
            outfitGarmentId: outfitGarmentId,
            outfitId: outfitId,
            garmentId: garmentId,
            scale: scale,
            positionX: positionX,
            positionY: positionY,
            rotation: rotation,
            createdAt: createdAt,
            deletedAt: deletedAt,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutfitsGarmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutfitsGarmentsTable,
    OutfitsGarment,
    $$OutfitsGarmentsTableFilterComposer,
    $$OutfitsGarmentsTableOrderingComposer,
    $$OutfitsGarmentsTableAnnotationComposer,
    $$OutfitsGarmentsTableCreateCompanionBuilder,
    $$OutfitsGarmentsTableUpdateCompanionBuilder,
    (
      OutfitsGarment,
      BaseReferences<_$AppDatabase, $OutfitsGarmentsTable, OutfitsGarment>
    ),
    OutfitsGarment,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$GarmentsTableTableManager get garments =>
      $$GarmentsTableTableManager(_db, _db.garments);
  $$GarmentCategoriesTableTableManager get garmentCategories =>
      $$GarmentCategoriesTableTableManager(_db, _db.garmentCategories);
  $$OutfitsTableTableManager get outfits =>
      $$OutfitsTableTableManager(_db, _db.outfits);
  $$OutfitsGarmentsTableTableManager get outfitsGarments =>
      $$OutfitsGarmentsTableTableManager(_db, _db.outfitsGarments);
}

mixin _$OutfitsDaoMixin on DatabaseAccessor<AppDatabase> {
  $OutfitsTable get outfits => attachedDatabase.outfits;
  $OutfitsGarmentsTable get outfitsGarments => attachedDatabase.outfitsGarments;
  $GarmentsTable get garments => attachedDatabase.garments;
}
