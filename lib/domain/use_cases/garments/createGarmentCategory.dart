import 'package:drift/drift.dart';
import '../../../data/db/repositories/garment_repository_impl.dart';
import '../../../data/db/database.dart';

class CreateGarmentCategory {
  final GarmentRepositoryImpl _garmentRepository;

  CreateGarmentCategory(this._garmentRepository);

  Future<void> execute(int categoryId, int garmentId) async {
    try {
      print(
          'CreateGarmentCategory: Creating garment category for category: $categoryId, garment: $garmentId');

      final garmentCategory = GarmentCategoriesCompanion(
        categoryId: Value(categoryId),
        garmentId: Value(garmentId),
        createdAt: Value(DateTime.now()),
        isActive: Value(true),
      );

      print(
          'CreateGarmentCategory: Garment category companion created successfully');

      await _garmentRepository.insertGarmentCategory(garmentCategory);

      print('CreateGarmentCategory: Garment category created successfully');
    } catch (e, stackTrace) {
      print('CreateGarmentCategory: Error creating garment category: $e');
      print('CreateGarmentCategory: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
