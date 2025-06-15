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
    return categories.map((c) =>
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
  }