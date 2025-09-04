import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/categories_table.dart';
import 'garment_dao.dart';

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

  /// Elimina una categoría y todos sus garments asociados en cascada
  Future<List<String>> softDeleteCategoryWithCascade(int id) async {
    try {
      print('CategoryDAO: Starting cascade delete for category: $id');

      // Crear instancia del GarmentDAO para eliminar garments
      final garmentDao = GarmentDao(db);

      // Eliminar todos los garments y garment categories de la categoría
      final deletedImagePaths =
          await garmentDao.softDeleteAllGarmentsByCategory(id);

      // Eliminar la categoría
      await softDeleteCategory(id);

      print(
          'CategoryDAO: Category cascade delete completed. ${deletedImagePaths.length} images will be deleted');
      return deletedImagePaths;
    } catch (e, stackTrace) {
      print('CategoryDAO: Error in cascade delete: $e');
      print('CategoryDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
