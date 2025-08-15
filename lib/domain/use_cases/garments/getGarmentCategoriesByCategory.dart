import '../../../data/db/repositories/garment_repository_impl.dart';
import '../../../domain/entities/garment_category.dart';

class GetGarmentCategoriesByCategory {
  final GarmentRepositoryImpl _garmentRepository;

  GetGarmentCategoriesByCategory(this._garmentRepository);

  Future<List<GarmentCategoryEntity>> execute(int categoryId) async {
    try {
      print(
          'GetGarmentCategoriesByCategory: Getting garment categories for category: $categoryId');

      final result =
          await _garmentRepository.getGarmentCategoriesByCategory(categoryId);

      print(
          'GetGarmentCategoriesByCategory: Found ${result.length} garment categories');

      return result;
    } catch (e, stackTrace) {
      print(
          'GetGarmentCategoriesByCategory: Error getting garment categories: $e');
      print('GetGarmentCategoriesByCategory: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
