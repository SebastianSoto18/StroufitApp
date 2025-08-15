import 'package:drift/drift.dart';

class Garments extends Table {
  IntColumn get garmentId => integer().autoIncrement()();
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
