import 'dart:math';
import '../../../data/db/repositories/garment_repository_impl.dart';
import '../../../domain/entities/garment_category.dart';

class GenerateOutfit {
  final GarmentRepositoryImpl _garmentRepository;

  GenerateOutfit(this._garmentRepository);

  Future<List<GarmentCategoryEntity>> execute(
      List<int> selectedCategoryIds) async {
    try {
      print(
          'GenerateOutfit: Starting outfit generation for categories: $selectedCategoryIds');

      if (selectedCategoryIds.isEmpty) {
        throw Exception('No categories selected for outfit generation');
      }

      // Obtener todas las garment categories de las categorías seleccionadas en paralelo
      final List<Future<List<GarmentCategoryEntity>>> futures =
          selectedCategoryIds
              .map((categoryId) =>
                  _garmentRepository.getGarmentCategoriesByCategory(categoryId))
              .toList();

      final List<List<GarmentCategoryEntity>> allGarmentCategories =
          await Future.wait(futures);

      print(
          'GenerateOutfit: Retrieved garment categories for all selected categories');

      // Aplanar la lista de garment categories
      final List<GarmentCategoryEntity> validGarmentCategories =
          allGarmentCategories.expand((list) => list).toList();

      if (validGarmentCategories.isEmpty) {
        throw Exception('No garments found for the selected categories');
      }

      print(
          'GenerateOutfit: Found ${validGarmentCategories.length} valid garment categories');

      // Seleccionar una garment category al azar para cada categoría
      final List<GarmentCategoryEntity> selectedOutfit = [];
      final Random random = Random();

      for (int categoryId in selectedCategoryIds) {
        final categoryGarments = validGarmentCategories
            .where((gc) => gc.categoryId == categoryId)
            .toList();

        if (categoryGarments.isNotEmpty) {
          final randomIndex = random.nextInt(categoryGarments.length);
          selectedOutfit.add(categoryGarments[randomIndex]);
          print(
              'GenerateOutfit: Selected garment ${categoryGarments[randomIndex].garmentId} for category $categoryId');
        }
      }

      print(
          'GenerateOutfit: Generated outfit with ${selectedOutfit.length} garments');
      return selectedOutfit;
    } catch (e, stackTrace) {
      print('GenerateOutfit: Error generating outfit: $e');
      print('GenerateOutfit: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
