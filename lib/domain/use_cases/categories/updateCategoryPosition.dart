import '../../repositories/category_repository.dart';

class UpdateCategoryPosition {
  final CategoryRepository _categoryRepository;

  UpdateCategoryPosition(this._categoryRepository);

  Future<void> execute(int categoryId, double scale, double positionX,
      double positionY, double rotation) async {
    await _categoryRepository.updateCategoryPosition(
        categoryId, scale, positionX, positionY, rotation);
  }
}
