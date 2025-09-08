import 'package:stroufitapp/domain/entities/garment.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';

class CategoryPosition {
  final double scale;
  final double positionX;
  final double positionY;
  final double rotation;

  CategoryPosition({
    required this.scale,
    required this.positionX,
    required this.positionY,
    required this.rotation,
  });
}

class GarmentCacheService {
  static final GarmentCacheService _instance = GarmentCacheService._internal();
  factory GarmentCacheService() => _instance;
  GarmentCacheService._internal();

  // Cache para GarmentCategories por categoría
  final Map<int, List<GarmentCategoryEntity>> _garmentCategoriesCache = {};

  // Cache para Garments individuales
  final Map<int, GarmentEntity> _garmentsCache = {};

  // Cache para posiciones de categorías
  final Map<int, CategoryPosition> _categoryPositionsCache = {};

  /// Obtiene las garment categories de una categoría desde el cache
  List<GarmentCategoryEntity>? getGarmentCategoriesFromCache(int categoryId) {
    return _garmentCategoriesCache[categoryId];
  }

  /// Guarda las garment categories de una categoría en el cache
  void cacheGarmentCategories(
      int categoryId, List<GarmentCategoryEntity> garmentCategories) {
    _garmentCategoriesCache[categoryId] = List.from(garmentCategories);

    // También cachear las garments individuales
    for (final garmentCategory in garmentCategories) {
      _garmentsCache[garmentCategory.garmentId] = garmentCategory.garment;
    }
  }

  /// Guarda una garment individual en el cache
  void cacheGarment(GarmentEntity garment) {
    _garmentsCache[garment.garmentId] = garment;
  }

  /// Obtiene una garment específica desde el cache
  GarmentEntity? getGarmentFromCache(int garmentId) {
    return _garmentsCache[garmentId];
  }

  /// Verifica si una categoría está en cache
  bool isCategoryCached(int categoryId) {
    return _garmentCategoriesCache.containsKey(categoryId);
  }

  /// Verifica si una garment está en cache
  bool isGarmentCached(int garmentId) {
    return _garmentsCache.containsKey(garmentId);
  }

  /// Invalida el cache de una categoría específica
  void invalidateCategoryCache(int categoryId) {
    final garmentCategories = _garmentCategoriesCache[categoryId];
    if (garmentCategories != null) {
      // Remover las garments de esta categoría del cache de garments
      for (final garmentCategory in garmentCategories) {
        _garmentsCache.remove(garmentCategory.garmentId);
      }
    }
    _garmentCategoriesCache.remove(categoryId);
  }

  /// Invalida el cache de una garment específica
  void invalidateGarmentCache(int garmentId) {
    _garmentsCache.remove(garmentId);

    // También invalidar las categorías que contengan esta garment
    _garmentCategoriesCache.removeWhere((categoryId, garmentCategories) {
      return garmentCategories.any((gc) => gc.garmentId == garmentId);
    });
  }

  /// Invalida todo el cache
  void invalidateAllCache() {
    _garmentCategoriesCache.clear();
    _garmentsCache.clear();
    _categoryPositionsCache.clear();
  }

  /// Guarda la posición de una categoría en el cache
  void cacheCategoryPosition(int categoryId, double scale, double positionX,
      double positionY, double rotation) {
    _categoryPositionsCache[categoryId] = CategoryPosition(
      scale: scale,
      positionX: positionX,
      positionY: positionY,
      rotation: rotation,
    );
  }

  /// Obtiene la posición de una categoría desde el cache
  CategoryPosition? getCategoryPositionFromCache(int categoryId) {
    return _categoryPositionsCache[categoryId];
  }

  /// Invalida la posición de una categoría específica
  void invalidateCategoryPositionCache(int categoryId) {
    _categoryPositionsCache.remove(categoryId);
  }

  /// Obtiene estadísticas del cache
  Map<String, int> getCacheStats() {
    return {
      'cachedCategories': _garmentCategoriesCache.length,
      'cachedGarments': _garmentsCache.length,
      'cachedPositions': _categoryPositionsCache.length,
      'totalGarmentCategories': _garmentCategoriesCache.values
          .fold(0, (sum, list) => sum + list.length),
    };
  }

  /// Limpia el cache de categorías que ya no existen
  void cleanInvalidCategories(List<int> validCategoryIds) {
    final keysToRemove = _garmentCategoriesCache.keys
        .where((categoryId) => !validCategoryIds.contains(categoryId))
        .toList();

    for (final categoryId in keysToRemove) {
      invalidateCategoryCache(categoryId);
    }
  }
}
