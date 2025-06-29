import '../../../data/db/repositories/category_repositoy_impl.dart';

class SoftDeleteCategory {
  final CategoryRepositoryImpl _repository;

  SoftDeleteCategory(this._repository);

  Future<void> execute(int id) async {
    await _repository.softDeleteCategory(id);
  }
}
