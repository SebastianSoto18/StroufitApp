import 'package:stroufitapp/domain/entities/category.dart';

import '../../data/db/database.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();
  Future<void> insertCategory(CategoriesCompanion category);
  Future<void> softDeleteCategory(int id);
  Future<void> updateCategory(CategoryEntity category);
}