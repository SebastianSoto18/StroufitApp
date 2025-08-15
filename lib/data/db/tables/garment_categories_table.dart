import 'package:drift/drift.dart';
import 'categories_table.dart';
import 'garments_table.dart';

class GarmentCategories extends Table {
  IntColumn get garmentCategoriesId => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #categoryId)();
  IntColumn get garmentId => integer().references(Garments, #garmentId)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
