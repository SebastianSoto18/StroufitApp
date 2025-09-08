import 'package:drift/drift.dart';

class OutfitsGarments extends Table {
  IntColumn get outfitGarmentId => integer().autoIncrement()();
  IntColumn get outfitId => integer()();
  IntColumn get garmentId => integer()();
  RealColumn get scale => real().withDefault(const Constant(1.0))();
  RealColumn get positionX => real().withDefault(const Constant(0.0))();
  RealColumn get positionY => real().withDefault(const Constant(0.0))();
  RealColumn get rotation => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
