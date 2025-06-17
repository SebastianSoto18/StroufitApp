


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/data/db/daos/categories_dao.dart';
import 'package:stroufitapp/domain/entities/category.dart';
import 'package:stroufitapp/domain/use_cases/categories/createCategory.dart';

import '../data/db/database.dart';
import '../data/db/repositories/category_repositoy_impl.dart';
import '../domain/use_cases/categories/deleteCategory.dart';
import '../domain/use_cases/categories/getAllCategories.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final categoryDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return CategoryDao(database);
});

final categoryRepositoryProvider = Provider((ref) {
  final dao = ref.watch(categoryDaoProvider);
  return CategoryRepositoryImpl(dao);
});

final getAllCategoriesUseCaseProvider = Provider((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return GetAllCategories(repository);
});

final categoryListProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final getAllCategoriesUseCase = ref.watch(getAllCategoriesUseCaseProvider);
  return await getAllCategoriesUseCase();
});


final insertCategoryProvider = FutureProvider.family<void, CategoriesCompanion>((ref, category) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return await repository.insertCategory(category);
});

final insertCategoryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return CreateCategory(repository);
});

final categorySearchQueryProvider = StateProvider<String>((ref) => '');

final filteredCategoryListProvider = Provider<List<CategoryEntity>>((ref) {
  final asyncCategories = ref.watch(categoryListProvider);
  final query = ref.watch(categorySearchQueryProvider).toLowerCase();

  return asyncCategories.maybeWhen(
    data: (entities) {
          entities
          .where((e) => e.name.toLowerCase().contains(query))
          .toList();

          entities.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          return entities;
    },
    orElse: () => [],
  );
});

final softDeleteCategoryUseCaseProvider = Provider<SoftDeleteCategory>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return SoftDeleteCategory(repository);
});

final softDeleteCategoryProvider = FutureProvider.family<void, int>((ref, id) async {
  final delete = ref.watch(softDeleteCategoryUseCaseProvider);
  await delete.execute(id);
  ref.invalidate(categoryListProvider);
});






