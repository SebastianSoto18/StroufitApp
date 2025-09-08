import 'package:drift/drift.dart';

class Outfits extends Table {
  IntColumn get outfitId => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
