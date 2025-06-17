

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

  Future<void> softDeleteCategory(int id) async {
    await (update(categories)..where((tbl) => tbl.categoryId.equals(id))).write(
      CategoriesCompanion(isActive: const Value(false), deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> updateCategory(CategoriesCompanion category) async {
    await (update(categories)..where((tbl) => tbl.categoryId.equals(category.categoryId.value)))
        .write(category);
  }


}