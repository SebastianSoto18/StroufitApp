import 'package:drift/drift.dart';
import 'package:stroufitapp/data/db/repositories/category_repositoy_impl.dart';

import '../../../data/db/database.dart';

class CreateCategory {
  final CategoryRepositoryImpl _categoryRepository;

  CreateCategory(this._categoryRepository);

  Future<void> execute(String name) async {
    final category = CategoriesCompanion(
      name: Value(name),
      createdAt: Value(DateTime.now()),
      isActive: Value(true),
    );

    try {
      return await _categoryRepository.insertCategory(category);
    } catch (e) {
      print('Error creating category: $e');
      throw e;
    }
  }

}