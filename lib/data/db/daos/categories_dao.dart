

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  Future<void> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }
}