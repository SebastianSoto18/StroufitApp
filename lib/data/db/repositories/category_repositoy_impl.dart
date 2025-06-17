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
    return categories.where((c) => c.isActive).map((c) =>
        CategoryEntity(categoryId: c.categoryId,
            name: c.name,
            createdAt: c.createdAt,
            isActive: c.isActive)).toList();
  }

  @override
  Future<void> insertCategory(CategoriesCompanion category) {
    try {
      return _categoryDao.insertCategory(category);
    } catch (e) {
      print('Error inserting category: $e');
      throw e;
    }
  }

  @override
  Future<void> softDeleteCategory(int id) {
    try {
      return _categoryDao.softDeleteCategory(id);
    } catch (e) {
      print('Error soft deleting category: $e');
      throw e;
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final companion = CategoriesCompanion(
      categoryId: Value(category.categoryId),
      name: Value(category.name),
      isActive: Value(category.isActive),
    );
    await _categoryDao.updateCategory(companion);
  }

}
