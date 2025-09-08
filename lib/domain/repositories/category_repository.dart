import 'package:stroufitapp/domain/entities/category.dart';

import '../../data/db/database.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();
  Future<void> insertCategory(CategoriesCompanion category);
  Future<void> softDeleteCategory(int id);
  Future<void> updateCategory(CategoryEntity category);
  Future<void> toggleFavorite(int categoryId, bool isFavorite);
  Future<List<String>> softDeleteCategoryWithCascade(int id);
  Future<void> updateCategoryPosition(int categoryId, double scale,
      double positionX, double positionY, double rotation);
}
