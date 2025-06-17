
import '../../entities/category.dart';
import '../../repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository _repository;

  UpdateCategory(this._repository);

  Future<void> execute(CategoryEntity updatedCategory) async {
    await _repository.updateCategory(updatedCategory);
  }
}
