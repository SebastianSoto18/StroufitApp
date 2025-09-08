import 'package:drift/drift.dart';
import 'package:stroufitapp/data/db/database.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/repositories/category_repository.dart';
import '../daos/categories_dao.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDao _categoryDao;

  CategoryRepositoryImpl(this._categoryDao);

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final categories = await _categoryDao.getAllCategories();
    return categories
        .where((c) => c.isActive)
        .map((c) => CategoryEntity(
            categoryId: c.categoryId,
            name: c.name,
            createdAt: c.createdAt,
            isActive: c.isActive,
            isFavorite: c.isFavorite,
            scale: c.scale,
            positionX: c.positionX,
            positionY: c.positionY,
            rotation: c.rotation))
        .toList();
  }

  @override
  Future<void> insertCategory(CategoriesCompanion category) {
    try {
      print('Repository: Inserting category: ${category.name.value}');
      return _categoryDao.insertCategory(category);
    } catch (e, stackTrace) {
      print('Repository: Error inserting category: $e');
      print('Repository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> softDeleteCategory(int id) {
    try {
      return _categoryDao.softDeleteCategory(id);
    } catch (e) {
      print('Error soft deleting category: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final companion = CategoriesCompanion(
      categoryId: Value(category.categoryId),
      name: Value(category.name),
      isActive: Value(category.isActive),
      isFavorite: Value(category.isFavorite),
    );
    await _categoryDao.updateCategory(companion);
  }

  @override
  Future<void> toggleFavorite(int categoryId, bool isFavorite) async {
    try {
      final companion = CategoriesCompanion(
        categoryId: Value(categoryId),
        isFavorite: Value(isFavorite),
      );
      await _categoryDao.updateCategory(companion);
    } catch (e, stackTrace) {
      print('Repository: Error toggling favorite: $e');
      print('Repository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Elimina una categoría y todos sus garments asociados en cascada
  @override
  Future<List<String>> softDeleteCategoryWithCascade(int id) async {
    try {
      print('Repository: Starting cascade delete for category: $id');
      return await _categoryDao.softDeleteCategoryWithCascade(id);
    } catch (e, stackTrace) {
      print('Repository: Error in cascade delete: $e');
      print('Repository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Actualiza la posición y escala de una categoría
  @override
  Future<void> updateCategoryPosition(int categoryId, double scale,
      double positionX, double positionY, double rotation) async {
    try {
      print('Repository: Updating position for category: $categoryId');
      await _categoryDao.updateCategoryPosition(
          categoryId, scale, positionX, positionY, rotation);
    } catch (e, stackTrace) {
      print('Repository: Error updating position: $e');
      print('Repository: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
