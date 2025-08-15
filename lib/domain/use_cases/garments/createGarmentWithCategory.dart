import '../../../data/db/repositories/garment_repository_impl.dart';
import 'createGarment.dart';
import 'createGarmentCategory.dart';

class CreateGarmentWithCategory {
  final GarmentRepositoryImpl _garmentRepository;

  CreateGarmentWithCategory(this._garmentRepository);

  Future<void> execute(int categoryId, String imagePath) async {
    try {
      print(
          'CreateGarmentWithCategory: Starting process for category: $categoryId, imagePath: $imagePath');

      // Primero creamos el garment
      final createGarment = CreateGarment(_garmentRepository);
      final garmentId = await createGarment.execute(imagePath);

      print(
          'CreateGarmentWithCategory: Garment created with ID: $garmentId, now creating relationship');

      // Luego creamos la relación garment-category
      final createGarmentCategory = CreateGarmentCategory(_garmentRepository);
      await createGarmentCategory.execute(categoryId, garmentId);

      print('CreateGarmentWithCategory: Process completed successfully');
    } catch (e, stackTrace) {
      print('CreateGarmentWithCategory: Error in process: $e');
      print('CreateGarmentWithCategory: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
