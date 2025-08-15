import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  final AppDatabase db;

  CategoryDao(this.db) : super(db);

  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  Future<void> insertCategory(CategoriesCompanion category) async {
    try {
      print('DAO: Inserting category: ${category.name.value}');
      await into(categories).insert(category);
      print('DAO: Category inserted successfully');
    } catch (e, stackTrace) {
      print('DAO: Error inserting category: $e');
      print('DAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> softDeleteCategory(int id) async {
    await (update(categories)..where((tbl) => tbl.categoryId.equals(id))).write(
      CategoriesCompanion(
          isActive: const Value(false), deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> updateCategory(CategoriesCompanion category) async {
    await (update(categories)
          ..where((tbl) => tbl.categoryId.equals(category.categoryId.value)))
        .write(category);
  }
}
