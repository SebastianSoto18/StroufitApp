import 'package:drift/drift.dart';
import 'package:stroufitapp/data/db/repositories/category_repositoy_impl.dart';

import '../../../data/db/database.dart';

class CreateCategory {
  final CategoryRepositoryImpl _categoryRepository;

  CreateCategory(this._categoryRepository);

  Future<void> execute(String name, {bool isFavorite = false}) async {
    try {
      print('Creating category with name: $name, isFavorite: $isFavorite');

      final category = CategoriesCompanion(
        name: Value(name),
        createdAt: Value(DateTime.now()),
        isActive: Value(true),
        isFavorite: Value(isFavorite),
      );

      print('Category companion created successfully');

      await _categoryRepository.insertCategory(category);

      print('Category inserted successfully');
    } catch (e, stackTrace) {
      print('Error creating category: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
