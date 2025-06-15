import 'package:stroufitapp/domain/entities/category.dart';

import '../../../data/db/repositories/category_repositoy_impl.dart';

class GetAllCategories {
  final CategoryRepositoryImpl _categoryRepository;

  GetAllCategories(this._categoryRepository);

  Future<List<CategoryEntity>> call() async {
    return await _categoryRepository.getAllCategories();
  }
}