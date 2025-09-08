import 'package:drift/drift.dart';

class Categories extends Table {
  IntColumn get categoryId => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  RealColumn get scale => real().withDefault(const Constant(1.0))();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  RealColumn get rotation => real().withDefault(const Constant(0.0))();
}
