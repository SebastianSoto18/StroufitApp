import 'package:drift/drift.dart';
import 'package:stroufitapp/domain/entities/category.dart';

class Categories extends Table {
  IntColumn get categoryId => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}