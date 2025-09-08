import 'dart:math';
import '../../../core/services/garment_cache_service.dart';
import '../../../data/db/repositories/garment_repository_impl.dart';
import '../../../domain/entities/garment_category.dart';

class CachedGenerateOutfit {
  final GarmentRepositoryImpl _garmentRepository;
  final GarmentCacheService _cacheService;

  CachedGenerateOutfit(this._garmentRepository, this._cacheService);

  Future<List<GarmentCategoryEntity>> execute(
      List<int> selectedCategoryIds) async {
    try {
      if (selectedCategoryIds.isEmpty) {
        throw Exception('No categories selected for outfit generation');
      }

      final List<GarmentCategoryEntity> allGarmentCategories = [];
      final List<int> categoriesToQuery = [];

      // Verificar qué categorías están en cache
      for (int categoryId in selectedCategoryIds) {
        final cachedCategories =
            _cacheService.getGarmentCategoriesFromCache(categoryId);
        if (cachedCategories != null) {
          allGarmentCategories.addAll(cachedCategories);
        } else {
          categoriesToQuery.add(categoryId);
        }
      }

      // Si hay categorías que no están en cache, consultarlas
      if (categoriesToQuery.isNotEmpty) {
        final List<Future<List<GarmentCategoryEntity>>> futures =
            categoriesToQuery
                .map((categoryId) => _garmentRepository
                    .getGarmentCategoriesByCategory(categoryId))
                .toList();

        final List<List<GarmentCategoryEntity>> queryResults =
            await Future.wait(futures);

        // Agregar resultados a la lista principal y cachear
        for (int i = 0; i < categoriesToQuery.length; i++) {
          final categoryId = categoriesToQuery[i];
          final garmentCategories = queryResults[i];
          allGarmentCategories.addAll(garmentCategories);

          // Cachear el resultado
          _cacheService.cacheGarmentCategories(categoryId, garmentCategories);
        }
      }

      if (allGarmentCategories.isEmpty) {
        throw Exception('No garments found for the selected categories');
      }

      // Seleccionar una garment category al azar para cada categoría
      final List<GarmentCategoryEntity> selectedOutfit = [];
      final Random random = Random();

      for (int categoryId in selectedCategoryIds) {
        final categoryGarments = allGarmentCategories
            .where((gc) => gc.categoryId == categoryId)
            .toList();

        if (categoryGarments.isNotEmpty) {
          final randomIndex = random.nextInt(categoryGarments.length);
          selectedOutfit.add(categoryGarments[randomIndex]);
        }
      }

      return selectedOutfit;
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene estadísticas del cache
  Map<String, int> getCacheStats() {
    return _cacheService.getCacheStats();
  }

  /// Limpia el cache
  void clearCache() {
    _cacheService.invalidateAllCache();
  }
}
