import '../../../data/db/repositories/category_repositoy_impl.dart';
import 'dart:io';

class SoftDeleteCategoryWithCascade {
  final CategoryRepositoryImpl _repository;

  SoftDeleteCategoryWithCascade(this._repository);

  Future<void> execute(int id) async {
    try {
      print('UseCase: Starting soft cascade delete for category: $id');

      // Solo eliminar soft delete - no eliminar archivos físicamente
      await _repository.softDeleteCategoryWithCascade(id);

      print('UseCase: Soft cascade delete completed successfully');
    } catch (e, stackTrace) {
      print('UseCase: Error in soft cascade delete: $e');
      print('UseCase: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
